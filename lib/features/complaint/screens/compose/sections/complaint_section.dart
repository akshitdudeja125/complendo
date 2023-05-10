import 'package:complaint_portal/common/utils/constants.dart';
import 'package:complaint_portal/common/utils/enums.dart';
import 'package:complaint_portal/common/utils/validators.dart';
import 'package:complaint_portal/common/widgets/dropdown_dialog.dart';
import 'package:complaint_portal/common/widgets/text_form_field_item.dart';
import 'package:complaint_portal/features/auth/providers/user_provider.dart';
import 'package:complaint_portal/features/complaint/screens/compose/sections/image_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/complaint_form_provider.dart';

class ComplaintSection extends ConsumerStatefulWidget {
  const ComplaintSection({super.key});

  @override
  ConsumerState<ComplaintSection> createState() => _ComplaintSectionState();
}

class _ComplaintSectionState extends ConsumerState<ComplaintSection> {
  @override
  void initState() {
    debugPrint('ComplaintSection initState');
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.watch(hostelProvider.notifier).state =
          ref.watch(userProvider).hostel!.value;
      ref.watch(roomNoProvider.notifier).state = ref.watch(userProvider).roomNo;
      roomNoController.text = ref.watch(userProvider).roomNo ?? '';
    });
  }

  late final TextEditingController roomNoController = TextEditingController();
  late final TextEditingController descriptionController =
      TextEditingController();
  late final TextEditingController titleController = TextEditingController();
  @override
  void dispose() {
    roomNoController.dispose();
    descriptionController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('ComplaintSection build');
    final isLoading = ref.watch(isLoadingProvider);
    return Column(
      children: [
        TextFormFieldItem(
          labelText: 'Hostel',
          controller:
              TextEditingController(text: ref.watch(hostelProvider).toString()),
          enabled: !isLoading,
          suffixIcon: isLoading ? null : FeatherIcons.chevronDown,
          canEdit: false,
          onSuffixTap: () async {
            final selected = await showDropDownDialog(
              title: 'Select Hostel',
              items: Hostel.getHostels(),
            );
            if (selected != null) {
              ref.watch(hostelProvider.notifier).state = selected;
            }
          },
        ),
        SizedBox(height: kFormSpacing),
        TextFormFieldItem(
          controller: roomNoController,
          onChanged: (value) {
            ref.watch(roomNoProvider.notifier).state = value;
          },
          labelText: 'Room No',
          validator: (String? value) {
            return isRoom(value);
          },
          allowDelete: !isLoading,
          enabled: !isLoading,
          onDelete: () {
            roomNoController.clear();
            ref.watch(roomNoProvider.notifier).state = null;
          },
        ),
        SizedBox(height: kFormSpacing),
        TextFormFieldItem(
          labelText: 'Complaint Category',
          controller: TextEditingController(
              text: ref.watch(complaintCategoryProvider) ?? 'Select'),
          canEdit: false,
          enabled: !isLoading,
          suffixIcon: isLoading ? null : FeatherIcons.chevronDown,
          onSuffixTap: () async {
            final selected = await showDropDownDialog(
              title: 'Select Complaint Category',
              items: complaintCategories,
            );
            if (selected != null) {
              ref.watch(complaintCategoryProvider.notifier).state = selected;
            }
          },
        ),
        SizedBox(height: kFormSpacing),
        TextFormFieldItem(
          labelText: 'Complaint Type',
          controller: TextEditingController(
              text: ref.watch(complaintTypeProvider) ?? 'Select'),
          // suffixIcon: FeatherIcons.chevronDown,
          canEdit: false,
          enabled: !isLoading,
          suffixIcon: isLoading ? null : FeatherIcons.chevronDown,
          onSuffixTap: () async {
            final selected = await showDropDownDialog(
              title: 'Select Complaint Type',
              items: ['Individual', 'Common'],
            );
            if (selected != null) {
              ref.watch(complaintTypeProvider.notifier).state = selected;
            }
          },
        ),
        SizedBox(height: kFormSpacing),
        TextFormFieldItem(
          onChanged: (value) {
            ref.watch(titleProvider.notifier).state = value;
          },
          controller: titleController,
          labelText: 'Title',
          validator: (String? value) {
            return isTitle(value);
          },
          // allowDelete: true,
          enabled: !isLoading,
          allowDelete: !isLoading,
          onDelete: () {
            titleController.clear();
            ref.watch(titleProvider.notifier).state = null;
          },
        ),
        SizedBox(height: kFormSpacing),
        TextFormFieldItem(
          labelText: 'Description',
          onChanged: (value) {
            ref.watch(descriptionProvider.notifier).state = value;
          },
          controller: descriptionController,
          validator: (String? value) {
            return isDescription(value);
          },
          enabled: !isLoading,
          allowDelete: !isLoading,
          onDelete: () {
            descriptionController.clear();
            ref.watch(descriptionProvider.notifier).state = null;
          },
          maxLines: 4,
        ),
        SizedBox(height: kFormSpacing),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(color: Colors.black.withOpacity(0.3)),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: ImageSection(ref: ref),
        ),
      ],
    );
  }
}
