import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:smart_fit_test_signal/core/injection.dart';
import 'package:smart_fit_test_signal/domain/entities/unity_query.dart';
import 'package:smart_fit_test_signal/helpers/app_assets.dart';
import 'package:smart_fit_test_signal/helpers/app_colors.dart';
import 'package:smart_fit_test_signal/helpers/i10n_helper.dart';
import 'package:smart_fit_test_signal/presentation/search_unity/search_card/search_controller.dart';

class SearchCard extends StatefulWidget {
  const SearchCard({
    super.key,
    required this.onSearch,
    required this.count,
  });

  final void Function(UnityQuery query) onSearch;
  final int? count;

  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  final controller = getIt<SearchFormController>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.lightGrey.withOpacity(0.2),
          width: 3,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                AppAssets.iconHour,
                height: 20,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                i10n(context).formHour,
                style: textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            i10n(context).formWhatTime,
            style: textTheme.headlineLarge,
          ),
          const Divider(
            thickness: 0.4,
          ),
          ...TimeRange.values
              .map(
                (e) => Column(
                  children: [
                    Row(
                      children: [
                        Radio<TimeRange>(
                          visualDensity: VisualDensity.compact,
                          activeColor: AppColors.lightGrey,
                          fillColor:
                              MaterialStatePropertyAll(AppColors.lightGrey),
                          value: e,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          groupValue: controller.time.watch(context),
                          onChanged: (value) {
                            if (value != null) {
                              controller.changeTime(value);
                            }
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          e.label(context),
                          style: textTheme.labelMedium,
                        ),
                        const Spacer(),
                        Text(
                          e.time(context),
                          style: textTheme.labelMedium,
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 0.4,
                    ),
                  ],
                ),
              )
              .toList(),
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                checkColor: Colors.white,
                activeColor: AppColors.lightGrey,
                value: controller.closedUnities.watch(context),
                onChanged: (value) {
                  controller.changeClosedUnities();
                },
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(child: Text(i10n(context).formShowClosed)),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: widget.count == null
                      ? SizedBox.square(
                          dimension: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                            valueColor:
                                AlwaysStoppedAnimation(AppColors.yellow),
                          ),
                        )
                      : Text("${i10n(context).formFinds}: ${widget.count}"),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 15,
              runSpacing: 10,
              runAlignment: WrapAlignment.center,
              children: [
                FilledButton(
                  onPressed: () {
                    widget.onSearch(
                      UnityQuery(
                        closedUnities: controller.closedUnities.value,
                        time: controller.time.value,
                      ),
                    );
                  },
                  child: Text(i10n(context).formFind.toUpperCase()),
                ),
                OutlinedButton(
                  onPressed: () {
                    controller.clean();
                    widget.onSearch(const UnityQuery());
                  },
                  child: Text(i10n(context).formClean.toUpperCase()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
