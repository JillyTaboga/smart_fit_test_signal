import 'package:flutter/material.dart';
import 'package:smart_fit_test_signal/domain/entities/rules_entity.dart';
import 'package:smart_fit_test_signal/helpers/app_colors.dart';

class LegendWidget extends StatelessWidget {
  const LegendWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
      decoration: BoxDecoration(
        color: AppColors.lightGrey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Wrap(
        spacing: 15,
        runSpacing: 10,
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        children: Permissions.values
            .map(
              (e) => Column(
                children: [
                  Text(
                    e.label(context),
                    style: textTheme.displayMedium,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: switch (e) {
                      Permissions.mask => [
                          RulesEntity.mask(true),
                          RulesEntity.mask(false),
                        ],
                      Permissions.towel => [
                          RulesEntity.towel(true),
                          RulesEntity.towel(false),
                        ],
                      Permissions.fountain => [
                          RulesEntity.fountain(true),
                          RulesEntity.fountain(false),
                        ],
                      Permissions.lockers => [
                          RulesEntity.lockerRoom(PermissionStatus.cleared),
                          RulesEntity.lockerRoom(PermissionStatus.partial),
                          RulesEntity.lockerRoom(PermissionStatus.closed),
                        ],
                    }
                        .map(
                          (p) => Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            child: Column(
                              children: [
                                Image.asset(
                                  p.asset,
                                  height: 45,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  p.permissionStatus.label(context),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
