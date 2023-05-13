import 'package:complaint_portal/common/theme/custom_colors.dart';
import 'package:complaint_portal/common/utils/constants.dart';
import 'package:complaint_portal/common/utils/validators.dart';
import 'package:complaint_portal/common/widgets/dialog.dart';
import 'package:complaint_portal/common/widgets/text_form_field_item.dart';
import 'package:complaint_portal/features/auth/providers/user_provider.dart';
import 'package:complaint_portal/features/complaint/repository/complaint_repository.dart';
import 'package:complaint_portal/features/complaint/screens/edit/edit_image_block.dart';
import 'package:complaint_portal/features/complaint/screens/edit/submit_complaint_form.dart';
import 'package:complaint_portal/models/complaint_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../../providers/edit_complaint_form_provider.dart';

class EditComplaintPage extends ConsumerStatefulWidget {
  final Complaint complaint;
  const EditComplaintPage({
    super.key,
    required this.complaint,
  });

  @override
  ConsumerState<EditComplaintPage> createState() => _EditComplaintPageState();
}

class _EditComplaintPageState extends ConsumerState<EditComplaintPage> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _roomNoController;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(hostelProvider.notifier).state = widget.complaint.hostel;
      ref.read(imageProvider.notifier).state = widget.complaint.imageLink;
    });

    _titleController = TextEditingController(text: widget.complaint.title);
    _descriptionController =
        TextEditingController(text: widget.complaint.description);
    _roomNoController = TextEditingController(text: widget.complaint.roomNo);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _roomNoController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final isLoading = ref.watch(isLoadingProvider);
    return Stack(
      children: [
        Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color:
                      ThemeColors.iconColorLight[Theme.of(context).brightness],
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              title: Row(
                children: [
                  Text(
                    'Edit Complaint',
                    style: TextStyles(Theme.of(context).brightness)
                        .appbarTextStyle,
                  ),
                  const Spacer(),
                  if (!isLoading)
                    IconButton(
                      icon: Icon(
                        FeatherIcons.trash2,
                        color:
                            ThemeColors.iconColor[Theme.of(context).brightness],
                      ),
                      onPressed: () async {
                        final result = await dialogResult('Delete Complaint',
                            'Are you sure you want to delete this complaint?');
                        if (result == true) {
                          await ref
                              .watch(complaintRepositoryProvider)
                              .deleteComplaint(widget.complaint.cid!, ref);
                          Get.back();
                          Get.back();
                        }
                      },
                    ),
                  const SizedBox(width: 5),
                  if (!isLoading)
                    IconButton(
                      icon: Icon(
                        FeatherIcons.save,
                        color:
                            ThemeColors.iconColor[Theme.of(context).brightness],
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final result = await dialogResult('Save Changes',
                              'Are you sure you want to save the changes?');
                          if (result == true) {
                            editComplaint(
                              ref,
                              user,
                              _titleController.text,
                              _descriptionController.text,
                              ref.read(hostelProvider),
                              widget.complaint.complaintType,
                              _roomNoController.text,
                              ref.read(imageProvider),
                              _formKey,
                              widget.complaint,
                            );
                          }
                        }
                      },
                    ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, top: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormFieldItem(
                        initValue: widget.complaint.cid,
                        enabled: false,
                        labelText: 'ID',
                      ),
                      SizedBox(height: kFormSpacing),
                      TextFormFieldItem(
                        initValue: widget.complaint.category,
                        enabled: false,
                        labelText: 'Category',
                      ),
                      SizedBox(height: kFormSpacing),
                      TextFormFieldItem(
                        initValue: widget.complaint.hostel.toString(),
                        enabled: false,
                        labelText: 'Hostel',
                      ),
                      SizedBox(height: kFormSpacing),
                      TextFormFieldItem(
                        initValue: widget.complaint.roomNo.toString(),
                        enabled: false,
                        labelText: 'RoomNo',
                      ),
                      SizedBox(height: kFormSpacing),
                      TextFormFieldItem(
                        validator: (String? value) {
                          return isTitle(value);
                        },
                        controller: _titleController,
                        labelText: 'Title',
                        enabled: !isLoading,
                        allowDelete: !isLoading,
                        onDelete: () {
                          _titleController.clear();
                        },
                      ),
                      SizedBox(height: kFormSpacing),
                      TextFormFieldItem(
                        controller: _descriptionController,
                        labelText: 'Description',
                        validator: (String? value) {
                          return isDescription(value);
                        },
                        maxLines: 4,
                        enabled: !isLoading,
                        allowDelete: !isLoading,
                        onDelete: () {
                          _descriptionController.clear();
                        },
                      ),
                      SizedBox(height: kFormSpacing),
                      const EditImageBlock(),
                      SizedBox(height: kFormSpacing),
                    ],
                  ),
                ),
              ),
            )),
        Consumer(builder: (context, ref, child) {
          debugPrint("Edit Complaint Page: Loading Consumer");
          return ref.watch(isLoadingProvider)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const SizedBox();
        }),
      ],
    );
  }
}
