import 'package:flutter/material.dart';
import 'package:smart_fit_test_signal/helpers/app_assets.dart';
import 'package:smart_fit_test_signal/helpers/i10n_helper.dart';

class RulesEntity {
  const RulesEntity._({
    required this.asset,
    required this.permission,
    required this.permissionStatus,
  });
  final String asset;
  final PermissionStatus permissionStatus;
  final Permissions permission;

  factory RulesEntity.mask(bool status) {
    return RulesEntity._(
      asset: status ? AppAssets.requiredMask : AppAssets.recommendedMask,
      permission: Permissions.mask,
      permissionStatus:
          status ? PermissionStatus.mandatory : PermissionStatus.recomended,
    );
  }

  factory RulesEntity.towel(bool status) {
    return RulesEntity._(
      asset: status ? AppAssets.requiredTowel : AppAssets.recommendedTowel,
      permission: Permissions.towel,
      permissionStatus:
          status ? PermissionStatus.mandatory : PermissionStatus.recomended,
    );
  }

  factory RulesEntity.fountain(bool status) {
    return RulesEntity._(
      asset: status ? AppAssets.partialFountain : AppAssets.forbiddenFountain,
      permission: Permissions.fountain,
      permissionStatus:
          status ? PermissionStatus.partial : PermissionStatus.forbidden,
    );
  }

  factory RulesEntity.lockerRoom(PermissionStatus status) {
    return RulesEntity._(
      asset: switch (status) {
        PermissionStatus.closed => AppAssets.forbiddenLockerroom,
        PermissionStatus.cleared => AppAssets.requiredLockerRoom,
        _ => AppAssets.partialLockerRoom,
      },
      permission: Permissions.lockers,
      permissionStatus: status,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RulesEntity &&
        other.asset == asset &&
        other.permissionStatus == permissionStatus &&
        other.permission == permission;
  }

  @override
  int get hashCode =>
      asset.hashCode ^ permissionStatus.hashCode ^ permission.hashCode;
}

enum Permissions {
  mask,
  towel,
  fountain,
  lockers;

  String label(BuildContext context) {
    return switch (this) {
      Permissions.mask => i10n(context).legendMask,
      Permissions.towel => i10n(context).legendTowel,
      Permissions.fountain => i10n(context).legendFountain,
      Permissions.lockers => i10n(context).legendLockers,
    };
  }
}

enum PermissionStatus {
  mandatory,
  recomended,
  partial,
  forbidden,
  cleared,
  closed;

  String label(BuildContext context) {
    return switch (this) {
      PermissionStatus.mandatory => i10n(context).legendMandatory,
      PermissionStatus.recomended => i10n(context).legendRecommended,
      PermissionStatus.partial => i10n(context).legendPartial,
      PermissionStatus.forbidden => i10n(context).legendForbidden,
      PermissionStatus.cleared => i10n(context).legendCleared,
      PermissionStatus.closed => i10n(context).legendClosed,
    };
  }
}
