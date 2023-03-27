// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class CustomElevatedButton extends ConsumerWidget {
//   const CustomElevatedButton({
//     Key? key,
//     required this.isLoadingProvider,
//     required this.onSubmit,
//   }) : super(key: key);
//   final StateProvider<bool> isLoadingProvider;
//   final Function onSubmit;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return ElevatedButton.icon(
//       style: ElevatedButton.styleFrom(
//         backgroundColor:
//             ref.watch(isLoadingProvider) ? Colors.grey : Colors.black,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//       ),
//       icon: ref.watch(isLoadingProvider)
//           ? const SizedBox(
//               height: 20,
//               width: 20,
//               child: CircularProgressIndicator(
//                 color: Colors.white,
//                 strokeWidth: 1,
//               ),
//             )
//           : const Icon(Icons.send),
//       label: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Text(
//           !ref.watch(isLoadingProvider) ? 'Submit' : 'Submiting',
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//           ),
//         ),
//       ),
//       onPressed: () {
//         ref.watch(isLoadingProvider) ? null : onSubmit;
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomElevatedButton extends ConsumerWidget {
  final StateProvider<bool> isLoadingProvider;
  final void Function() onClick;
  const CustomElevatedButton({
    super.key,
    required this.isLoadingProvider,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(isLoadingProvider);

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: isLoading ? Colors.grey : Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      icon: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 1,
              ),
            )
          : const Icon(Icons.send),
      label: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          isLoading ? 'Submitting' : 'Submit',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      onPressed: isLoading ? null : onClick,
    );
  }
}
