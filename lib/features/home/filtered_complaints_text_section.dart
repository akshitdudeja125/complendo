import 'package:complaint_portal/common/theme/custom_colors.dart';
import 'package:complaint_portal/features/home/filter/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterTextSection extends ConsumerWidget {
  @override
  const FilterTextSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Consumer(builder: (BuildContext context, WidgetRef ref, _) {
        final filterOptions = ref.watch(complaintFilterOptionsProvider);
        if (filterOptions['selectedDateRange'] == null &&
            filterOptions['status'].isEmpty &&
            filterOptions['category'].isEmpty &&
            filterOptions['hostel'].isEmpty) {
          return const SizedBox();
        } else {
          return Text.rich(
            TextSpan(
              text: "Showing filtered complaints",
              style: TextStyle(
                fontSize: 15,
                color:
                    ThemeColors.homePageFontColor[Theme.of(context).brightness],
                fontWeight: FontWeight.w300,
              ),
              children: filterOptions['selectedDateRange'] == null
                  ? []
                  : [
                      const TextSpan(
                        text: " from ",
                      ),
                      TextSpan(
                        text: filterOptions['selectedDateRange']!
                            .start
                            .toLocal()
                            .toString()
                            .split(" ")[0],
                        style: TextStyle(
                          fontSize: 15,
                          color: ThemeColors
                              .homePageFontColor[Theme.of(context).brightness],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const TextSpan(
                        text: " to ",
                      ),
                      TextSpan(
                        text: filterOptions['selectedDateRange']!
                            .end
                            .toLocal()
                            .toString()
                            .split(" ")[0],
                        style: TextStyle(
                          fontSize: 15,
                          color: ThemeColors
                              .homePageFontColor[Theme.of(context).brightness],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
            ),
          );
        }
      }),
    );
  }
}
