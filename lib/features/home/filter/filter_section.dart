import 'package:complaint_portal/common/theme/custom_colors.dart';
import 'package:complaint_portal/common/utils/constants.dart';
import 'package:complaint_portal/features/home/filter/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterSection extends ConsumerWidget {
  final String headerText;
  final String filtername;
  const FilterSection({
    super.key,
    required this.headerText,
    required this.filtername,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Center(
          child: Text(
            headerText,
            style: TextStyles(Theme.of(context).brightness)
                .filtersubHeaderTextStyle,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          children: [
            for (var e in filterOptions[filtername]!)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 2.5, vertical: 2),
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: FilterChip(
                      showCheckmark: false,
                      pressElevation: 0,
                      // selectedFilterChipColor
                      selectedColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey.shade400
                              : const Color.fromARGB(255, 6, 56, 97),
                      // selectedColor: Theme.of(context).brightness ==
                      //         Brightness.dark
                      //     ? ThemeColors.selectedFilterChipColor[Brightness.dark]
                      //     : ThemeColors
                      //         .selectedFilterChipColor[Brightness.light],
                      label: Text(
                        e,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: ref
                                    .watch(complaintFilterOptionsProvider)[
                                        filtername]!
                                    .contains(e)
                                ? ThemeColors.selectedFilterChipTextColor[
                                    Theme.of(context).brightness]
                                : ThemeColors.unselectedFilterChipTextColor[
                                    Theme.of(context).brightness]),
                      ),
                      labelPadding: const EdgeInsets.all(0),
                      selected: ref
                          .watch(complaintFilterOptionsProvider)[filtername]!
                          .contains(e),
                      onSelected: (value) {
                        ref
                            .read(complaintFilterOptionsProvider.notifier)
                            .state = {
                          ...ref.watch(complaintFilterOptionsProvider),
                          filtername: value
                              ? [
                                  ...ref.watch(complaintFilterOptionsProvider)[
                                      filtername]!,
                                  e
                                ]
                              : ref
                                  .watch(complaintFilterOptionsProvider)[
                                      filtername]!
                                  .where((element) => element != e)
                                  .toList(),
                        };
                      }),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
