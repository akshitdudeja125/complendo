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
                      child: Container(
                        // padding: const EdgeInsets.symmetric(horizontal: 11),
                        child: Text(
                          item,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 16),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    ],
  );
}








// // ignore_for_file: prefer_typing_uninitialized_variables

// import 'package:flutter/material.dart';
// // import 'package:get/get.dart';

// class DropDownList extends StatefulWidget {
//   final List<String> dropDownList;

//   final controller;

//   const DropDownList({
//     super.key,
//     required this.dropDownList,
//     required this.controller,
//   });
//   @override
//   State<DropDownList> createState() => _DropDownListState();
// }

// class _DropDownListState extends State<DropDownList> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Align(
//           alignment: Alignment.centerLeft,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               "Complaint Type",
//               style: Theme.of(context).textTheme.bodyMedium,
//             ),
//           ),
//         ),
//         Container(
//           decoration: BoxDecoration(
//             shape: BoxShape.rectangle,
//             border: Border.all(color: Colors.black.withOpacity(0.3)),
//             borderRadius: const BorderRadius.all(Radius.circular(20)),
//           ),
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton<String>(
//                 hint: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 11),
//                   child: Text(
//                     widget.controller.dropDownValue.value,
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodyMedium
//                         ?.copyWith(fontSize: 16),
//                   ),
//                 ),
//                 value: widget.controller.dropDownValue.value,
//                 onChanged: (String? value) {
//                   setState(() {
//                     widget.controller.dropDownValue.value = value!;
//                   });
//                 },
//                 isExpanded: true,
//                 style: Theme.of(context).textTheme.bodyLarge,
//                 items: <String>["Select", ...widget.controller.dropDownList]
//                     .map((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 11),
//                       child: Text(
//                         value,
//                         style: Theme.of(context)
//                             .textTheme
//                             .bodyMedium
//                             ?.copyWith(fontSize: 16),
//                       ),
//                     ),
//                   );
//                 }).toList()),
//           ),
//         ),
//       ],
//     );
//   }
// }



// import 'package:flutter/material.dart';
// // import 'package:get/get.dart';

// class DropDownList extends StatefulWidget {
//   final List<String> dropDownList;

//   // final controller;

//   const DropDownList({
//     super.key,
//     required this.dropDownList,
//     // required this.controller,
//   });
//   @override
//   State<DropDownList> createState() => _DropDownListState();
// }

// class _DropDownListState extends State<DropDownList> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         shape: BoxShape.rectangle,
//         border: Border.all(color: Colors.black.withOpacity(0.3)),
//         borderRadius: const BorderRadius.all(Radius.circular(20)),
//       ),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<String>(
//             hint: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 11),
//               child: Text(
//                 widget.controller.dropDownValue.value,
//                 style: Theme.of(context)
//                     .textTheme
//                     .bodyMedium
//                     ?.copyWith(fontSize: 16),
//               ),
//             ),
//             value: widget.controller.dropDownValue.value,
//             onChanged: (String? value) {
//               setState(() {
//                 widget.controller.dropDownValue.value = value!;
//               });
//             },
//             isExpanded: true,
//             style: Theme.of(context).textTheme.bodyLarge,
//             items: <String>["Select", ...widget.controller.dropDownList]
//                 .map((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 11),
//                   child: Text(
//                     value,
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodyMedium
//                         ?.copyWith(fontSize: 16),
//                   ),
//                 ),
//               );
//             }).toList()),
//       ),
//     );
//   }
// }