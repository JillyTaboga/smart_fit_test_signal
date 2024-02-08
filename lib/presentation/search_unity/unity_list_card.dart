import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:smart_fit_test_signal/domain/entities/unity_entity.dart';
import 'package:smart_fit_test_signal/helpers/app_colors.dart';
import 'package:smart_fit_test_signal/helpers/i10n_helper.dart';

class UnitiesListWidget extends StatelessWidget {
  const UnitiesListWidget({
    super.key,
    required this.unities,
  });

  final List<UnityEntity> unities;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const height = 300.0;
        final textTheme = Theme.of(context).textTheme;
        return SizedBox(
          height: height,
          child: unities.isEmpty
              ? Center(
                  child: Text(
                    i10n(context).unitiesEmpty,
                    style: textTheme.displayMedium,
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(left: 20),
                  scrollDirection: Axis.horizontal,
                  itemCount: unities.length,
                  itemBuilder: (context, index) {
                    final unity = unities[index];
                    return Container(
                      width: 220,
                      height: double.maxFinite,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        height: double.maxFinite,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: AppColors.lightGrey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              unity.status.label(context),
                              style: TextStyle(
                                color: unity.status.color,
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              unity.name,
                              maxLines: 1,
                              style: textTheme.displayLarge,
                            ),
                            SizedBox(
                              height: 65,
                              child: Html(
                                data: unity.address,
                                style: {
                                  "p": Style.fromTextStyle(textTheme.bodySmall!)
                                      .copyWith(
                                    padding: HtmlPaddings.all(0),
                                    before: '',
                                    margin: Margins.all(0),
                                    maxLines: 3,
                                  ),
                                },
                              ),
                            ),
                            const Divider(),
                            Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              runAlignment: WrapAlignment.spaceBetween,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: unity.rules
                                  .map(
                                    (e) => Image.asset(
                                      e.asset,
                                      height: 40,
                                      width: 40,
                                    ),
                                  )
                                  .toList(),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Wrap(
                                  alignment: WrapAlignment.spaceBetween,
                                  runAlignment: WrapAlignment.spaceBetween,
                                  crossAxisAlignment: WrapCrossAlignment.start,
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: unity.schedules
                                      .map(
                                        (e) => Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              e.label,
                                              style: textTheme.displayMedium,
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            if (e.closed)
                                              Text(i10n(context).closed),
                                            if (e.obs?.isNotEmpty ?? false)
                                              Text(e.obs!),
                                            if (e.start != null &&
                                                e.end != null)
                                              Text(
                                                i10n(context).range(
                                                  e.start!.hour.toString(),
                                                  e.start!.minute == 0
                                                      ? ""
                                                      : e.start!.minute
                                                          .toString(),
                                                  e.end!.hour.toString(),
                                                  e.end!.minute == 0
                                                      ? ""
                                                      : e.end!.minute
                                                          .toString(),
                                                ),
                                              ),
                                          ],
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
