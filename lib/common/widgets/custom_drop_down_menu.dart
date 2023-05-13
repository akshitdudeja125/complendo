// ignore_for_file: library_private_types_in_public_api

import 'package:complaint_portal/common/utils/constants.dart';
import 'package:complaint_portal/features/complaint/screens/view/view_complaint_screen.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

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
      DropdownButtonHideUnderline(
        child: DropdownButtonFormField2(
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          hint: Text(
            hintText,
            style:
                Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 16),
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
    ],
  );
}
// Column customDropDownMenu({
//   String? headerText,
//   required String hintText,
//   required List<String> items,
//   required String? value,
//   required Function(String?) onChanged,
//   String? Function(dynamic value)? validator,
//   required BuildContext context,
//   initValue,
// }) {
//   if (initValue != null) {
//     value = initValue;
//   }
//   return Column(
//     children: [
//       headerText == null
//           ? const SizedBox()
//           : Align(
//               alignment: Alignment.centerLeft,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   headerText,
//                   style: Theme.of(context).textTheme.bodyMedium,
//                 ),
//               ),
//             ),
//       // TextFormField(),
//       Container(
//         decoration: BoxDecoration(
//           shape: BoxShape.rectangle,
//           border: Border.all(color: Colors.black.withOpacity(0.3)),
//           borderRadius: const BorderRadius.all(Radius.circular(20)),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton(
//               // underline: Container(
//               //   height: 1,
//               //   color: Colors.black.withOpacity(0.3),
//               // ),
//               autofocus: false,
//               focusNode: FocusNode(),
//               icon: const Icon(FeatherIcons.chevronDown),
//               borderRadius: const BorderRadius.all(Radius.circular(20)),
//               hint: Text(
//                 hintText,
//                 style: Theme.of(context)
//                     .textTheme
//                     .bodyMedium
//                     ?.copyWith(fontSize: 16),
//               ),
//               value: value,
//               onChanged: onChanged,
//               disabledHint: Text(
//                 hintText,
//                 style: Theme.of(context)
//                     .textTheme
//                     .bodyMedium
//                     ?.copyWith(fontSize: 16),
//               ),

//               // validator: validator,
//               isExpanded: true,
//               items: items
//                   .map((item) => DropdownMenuItem<String>(
//                         value: item,
//                         child: Text(
//                           item,
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodyMedium
//                               ?.copyWith(fontSize: 16),
//                         ),
//                       ))
//                   .toList(),
//             ),
//           ),
//         ),
//       ),
//     ],
//   );
// }


// Column customDropDownMenu({
//   String? headerText,
//   required String hintText,
//   required List<String> items,
//   required String? value,
//   required Function(String?) onChanged,
//   String? Function(dynamic value)? validator,
//   required BuildContext context,
//   initValue,
// }) {
//   if (initValue != null) {
//     value = initValue;
//   }
//   return Column(
//     children: [
//       // headerText == null
//       //     ? const SizedBox()
//       //     : Align(
//       //         alignment: Alignment.centerLeft,
//       //         child: Padding(
//       //           padding: const EdgeInsets.all(8.0),
//       //           child: Text(
//       //             headerText,
//       //             style: Theme.of(context).textTheme.bodyMedium,
//       //           ),
//       //         ),
//       //       ),
//       Container(
//         // decoration: BoxDecoration(
//         //   shape: BoxShape.rectangle,
//         //   border: Border.all(color: Colors.black.withOpacity(0.3)),
//         //   borderRadius: const BorderRadius.all(Radius.circular(20)),
//         // ),
//         // OutlineInputBorder(
//         //   borderSide: BorderSide.none,
//         // ),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButtonFormField2(
//             autofocus: false,
//             // dropdownSearchData:
//             dropdownStyleData: DropdownStyleData(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//             ),
//             items: items
//                 .map((item) => DropdownMenuItem<String>(
//                       value: item,
//                       child: Text(
//                         item,
//                         style: Theme.of(context)
//                             .textTheme
//                             .bodyMedium
//                             ?.copyWith(fontSize: 16),
//                       ),
//                     ))
//                 .toList(),
//             onChanged: onChanged,
//             validator: validator,
//             value: value,
//             buttonStyleData: const ButtonStyleData(),
//             iconStyleData: const IconStyleData(
//               icon: Icon(
//                 FeatherIcons.chevronDown,
//                 color: Colors.black45,
//               ),
//               iconSize: 30,
//             ),
//             isExpanded: true,
//             hint: Container(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 hintText,
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 1,
//                 style: Theme.of(context)
//                     .textTheme
//                     .bodyMedium
//                     ?.copyWith(fontSize: 16),
//               ),
//             ),
//             // decoration: InputDecoration(
//             //   border: OutlineInputBorder(
//             //     borderSide: BorderSide.none,

//             //   ),
//             // )
//           ),
//         ),
//       ),
//     ],
//   );
// }

// Column customDropDownMenu2({
//   String? headerText,
//   required String hintText,
//   required List<String> items,
//   required String? value,
//   required ref,
//   required provider,
//   // required Function(String?) onChanged,
//   required BuildContext context,
// }) {
//   return Column(
//     children: [
//       headerText == null
//           ? const SizedBox()
//           : Align(
//               alignment: Alignment.centerLeft,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   headerText,
//                 ),
//               ),
//             ),
//       GestureDetector(
//         onTap: () {
//           customDropDownMenu1(
//             context: context,
//             ref: ref,
//             provider: provider,
//             item: items,
//             hintText: hintText,
//           );
//         },
//         child: Container(
//           height: 60,
//           decoration: BoxDecoration(
//             shape: BoxShape.rectangle,
//             border: Border.all(color: Colors.black.withOpacity(0.3)),
//             borderRadius: const BorderRadius.all(Radius.circular(20)),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   ref.watch(provider) ?? hintText,
//                 ),
//               ),
//               const Icon(Icons.arrow_drop_down),
//             ],
//           ),
//         ),
//       ),
//     ],
//   );
// }


// customDropDownMenu1({
//   required context,
//   required ref,
//   required provider,
//   required hintText,
//   required List<String> item,
//   isSearchVisible = false,
// }) {
//   return DropDownState(
//     DropDown(
//       isSearchVisible: isSearchVisible,
//       bottomSheetTitle: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Text(
//           hintText,
//           style: const TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 20.0,
//           ),
//         ),
//       ),
//       selectedItems: (item) {
//         ref.read(provider.notifier).state = item[0].name;
//       },
//       data: [
//         for (var i = 0; i < item.length; i++)
//           SelectedListItem(
//             name: item[i],
//           ),
//       ],
//     ),
//   ).showModal(context);
// }

// class CustDropDown<T> extends StatefulWidget {
//   final List<CustDropdownMenuItem> items;
//   final Function onChanged;
//   final String hintText;
//   final double borderRadius;
//   final double maxListHeight;
//   final double borderWidth;
//   final int defaultSelectedIndex;
//   final bool enabled;

//   const CustDropDown(
//       {required this.items,
//       required this.onChanged,
//       this.hintText = "",
//       this.borderRadius = 0,
//       this.borderWidth = 1,
//       this.maxListHeight = 100,
//       this.defaultSelectedIndex = -1,
//       Key? key,
//       this.enabled = true})
//       : super(key: key);

//   @override
//   _CustDropDownState createState() => _CustDropDownState();
// }

// class _CustDropDownState extends State<CustDropDown>
//     with WidgetsBindingObserver {
//   bool _isOpen = false, _isAnyItemSelected = false, _isReverse = false;
//   late OverlayEntry _overlayEntry;
//   late RenderBox? _renderBox;
//   Widget? _itemSelected;
//   late Offset dropDownOffset;
//   final LayerLink _layerLink = LayerLink();

//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (mounted) {
//         setState(() {
//           dropDownOffset = getOffset();
//         });
//       }
//       if (widget.defaultSelectedIndex > -1) {
//         if (widget.defaultSelectedIndex < widget.items.length) {
//           if (mounted) {
//             setState(() {
//               _isAnyItemSelected = true;
//               _itemSelected = widget.items[widget.defaultSelectedIndex];
//               widget.onChanged(widget.items[widget.defaultSelectedIndex].value);
//             });
//           }
//         }
//       }
//     });
//     WidgetsBinding.instance.addObserver(this);
//     super.initState();
//   }

//   void _addOverlay() {
//     if (mounted) {
//       setState(() {
//         _isOpen = true;
//       });
//     }

//     _overlayEntry = _createOverlayEntry();
//     Overlay.of(context).insert(_overlayEntry);
//   }

//   void _removeOverlay() {
//     if (mounted) {
//       setState(() {
//         _isOpen = false;
//       });
//       _overlayEntry.remove();
//     }
//   }

//   @override
//   dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   OverlayEntry _createOverlayEntry() {
//     _renderBox = context.findRenderObject() as RenderBox?;

//     var size = _renderBox!.size;

//     dropDownOffset = getOffset();

//     return OverlayEntry(
//         maintainState: false,
//         builder: (context) => Align(
//               alignment: Alignment.center,
//               child: CompositedTransformFollower(
//                 link: _layerLink,
//                 showWhenUnlinked: false,
//                 offset: dropDownOffset,
//                 child: SizedBox(
//                   height: widget.maxListHeight,
//                   width: size.width,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: _isReverse
//                         ? MainAxisAlignment.end
//                         : MainAxisAlignment.start,
//                     children: <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.only(top: 10),
//                         child: Container(
//                           constraints: BoxConstraints(
//                               maxHeight: widget.maxListHeight,
//                               maxWidth: size.width),
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(12)),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(widget.borderRadius),
//                             ),
//                             child: Material(
//                               elevation: 0,
//                               shadowColor: Colors.grey,
//                               child: ListView(
//                                 padding: EdgeInsets.zero,
//                                 shrinkWrap: true,
//                                 children: widget.items
//                                     .map((item) => GestureDetector(
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: item.child,
//                                           ),
//                                           onTap: () {
//                                             if (mounted) {
//                                               setState(() {
//                                                 _isAnyItemSelected = true;
//                                                 _itemSelected = item.child;
//                                                 _removeOverlay();
//                                                 if (widget.onChanged != null)
//                                                   widget.onChanged(item.value);
//                                               });
//                                             }
//                                           },
//                                         ))
//                                     .toList(),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ));
//   }

//   Offset getOffset() {
//     RenderBox? renderBox = context.findRenderObject() as RenderBox?;
//     double y = renderBox!.localToGlobal(Offset.zero).dy;
//     double spaceAvailable = _getAvailableSpace(y + renderBox.size.height);
//     if (spaceAvailable > widget.maxListHeight) {
//       _isReverse = false;
//       return Offset(0, renderBox.size.height);
//     } else {
//       _isReverse = true;
//       return Offset(
//           0,
//           renderBox.size.height -
//               (widget.maxListHeight + renderBox.size.height));
//     }
//   }

//   double _getAvailableSpace(double offsetY) {
//     double safePaddingTop = MediaQuery.of(context).padding.top;
//     double safePaddingBottom = MediaQuery.of(context).padding.bottom;

//     double screenHeight =
//         MediaQuery.of(context).size.height - safePaddingBottom - safePaddingTop;

//     return screenHeight - offsetY;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CompositedTransformTarget(
//       link: _layerLink,
//       child: GestureDetector(
//         onTap: widget.enabled
//             ? () {
//                 _isOpen ? _removeOverlay() : _addOverlay();
//               }
//             : null,
//         child: Container(
//           decoration: _getDecoration(),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Flexible(
//                 flex: 3,
//                 child: _isAnyItemSelected
//                     ? Padding(
//                         padding: const EdgeInsets.only(left: 4.0),
//                         child: _itemSelected!,
//                       )
//                     : Padding(
//                         padding:
//                             const EdgeInsets.only(left: 4.0), // change it here
//                         child: Text(
//                           widget.hintText,
//                           maxLines: 1,
//                           overflow: TextOverflow.clip,
//                         ),
//                       ),
//               ),
//               const Flexible(
//                 flex: 1,
//                 child: Icon(
//                   Icons.arrow_drop_down,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Decoration? _getDecoration() {
//     if (_isOpen && !_isReverse) {
//       return BoxDecoration(
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(widget.borderRadius),
//               topRight: Radius.circular(
//                 widget.borderRadius,
//               )));
//     } else if (_isOpen && _isReverse) {
//       return BoxDecoration(
//           borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(widget.borderRadius),
//               bottomRight: Radius.circular(
//                 widget.borderRadius,
//               )));
//     } else if (!_isOpen) {
//       return BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)));
//     }
//   }
// }

// class CustDropdownMenuItem<T> extends StatelessWidget {
//   final T value;
//   final Widget child;

//   const CustDropdownMenuItem(
//       {super.key, required this.value, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return child;
//   }
// }
