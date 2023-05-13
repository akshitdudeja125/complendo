import 'package:complaint_portal/common/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubmitButton extends ConsumerWidget {
  final StateProvider<bool> isLoadingProvider;
  final void Function() onClick;
  const SubmitButton({
    super.key,
    required this.isLoadingProvider,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(isLoadingProvider);

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: isLoading
            ? ThemeColors
                .submitButtonLoadingBgColor[Theme.of(context).brightness]
            : ThemeColors
                .submitButtonNotLoadingBgColor[Theme.of(context).brightness],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      icon: isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: ThemeColors
                    .submitButtonLoadingIconColor[Theme.of(context).brightness],
                strokeWidth: 1,
              ),
            )
          : Icon(
              Icons.send,
              color: ThemeColors.submitButtonNotLoadingIconColor[
                  Theme.of(context).brightness],
            ),
      label: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          isLoading ? 'Submitting' : 'Submit',
          style: TextStyle(
            color:
                ThemeColors.submitButtonTextColor[Theme.of(context).brightness],
            fontSize: 18,
          ),
        ),
      ),
      onPressed: isLoading ? null : onClick,
    );
  }
}
