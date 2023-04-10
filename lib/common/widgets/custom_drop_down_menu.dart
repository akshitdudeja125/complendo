import 'package:complaint_portal/common/utils/constants.dart';
import 'package:complaint_portal/features/complaint/screen/view_complaint_screen.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

Column customDropDownMenu({
  String? headerText,
  required String hintText,
  required List<String> items,
  required String? value,
  required Function(String?) onChanged,
  String? Function(dynamic value)? validator,
  required BuildContext context,
  initValue,
}) {
  if (initValue != null) {
    value = initValue;
  }
  return Column(
    children: [
      headerText == null
          ? const SizedBox()
          : Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  headerText,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
      Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.black.withOpacity(0.3)),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField2(
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            hint: Text(
              hintText,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 16),
            ),
            value: value,
            onChanged: onChanged,
            validator: validator,
            isExpanded: true,
            items: items
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: 16),
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    ],
  );
}

Column customDropDownMenu2({
  String? headerText,
  required String hintText,
  required List<String> items,
  required String? value,
  required ref,
  required provider,
  // required Function(String?) onChanged,
  required BuildContext context,
}) {
  return Column(
    children: [
      headerText == null
          ? const SizedBox()
          : Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  headerText,
                ),
              ),
            ),
      GestureDetector(
        onTap: () {
          customDropDownMenu1(
            context: context,
            ref: ref,
            provider: provider,
            item: items,
            hintText: hintText,
          );
        },
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(color: Colors.black.withOpacity(0.3)),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  ref.watch(provider) ?? hintText,
                ),
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    ],
  );
}

customDropDownMenu1({
  required context,
  required ref,
  required provider,
  required hintText,
  required List<String> item,
  isSearchVisible = false,
}) {
  return DropDownState(
    DropDown(
      isSearchVisible: isSearchVisible,
      bottomSheetTitle: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          hintText,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
      ),
      selectedItems: (item) {
        ref.read(provider.notifier).state = item[0].name;
      },
      data: [
        for (var i = 0; i < item.length; i++)
          SelectedListItem(
            name: item[i],
          ),
      ],
    ),
  ).showModal(context);
}
