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
        Text(
          headerText,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Wrap(
          children: [
            for (var e in filterOptions[filtername]!)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.5),
                child: FilterChip(
                    showCheckmark: false,
                    pressElevation: 0,
                    selectedColor: Colors.blue,
                    label: Text(e),
                    labelPadding: const EdgeInsets.all(0),
                    selected: ref
                        .watch(filteredOptionsProvider)[filtername]!
                        .contains(e),
                    onSelected: (value) {
                      ref.read(filteredOptionsProvider.notifier).state = {
                        ...ref.watch(filteredOptionsProvider),
                        filtername: value
                            ? [
                                ...ref.watch(
                                    filteredOptionsProvider)[filtername]!,
                                e
                              ]
                            : ref
                                .watch(filteredOptionsProvider)[filtername]!
                                .where((element) => element != e)
                                .toList(),
                      };
                    }),
              ),
          ],
        ),
      ],
    );
  }
}
