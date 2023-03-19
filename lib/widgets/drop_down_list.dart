import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropDownList extends StatefulWidget {
  final List<String> dropDownList;

  final controller;

  const DropDownList({
    super.key,
    required this.dropDownList,
    required this.controller,
  });
  @override
  State<DropDownList> createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(color: Colors.black.withOpacity(0.3)),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Obx(
        () => DropdownButtonHideUnderline(
          child: DropdownButton<String>(
              hint: Container(
                padding: const EdgeInsets.symmetric(horizontal: 11),
                child: Text(
                  widget.controller.dropDownValue.value,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontSize: 16),
                ),
              ),
              value: widget.controller.dropDownValue.value,
              onChanged: (String? value) {
                setState(() {
                  widget.controller.dropDownValue.value = value!;
                });
              },
              isExpanded: true,
              style: Theme.of(context).textTheme.bodyLarge,
              items: <String>["Select", ...widget.controller.dropDownList]
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 11),
                    child: Text(
                      value,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 16),
                    ),
                  ),
                );
              }).toList()),
        ),
      ),
    );
  }
}
