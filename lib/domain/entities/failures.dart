import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smart_fit_test_signal/helpers/i10n_helper.dart';

abstract class Failure {
  const Failure(
    this.message, {
    this.stackTrace,
  });
  final String message;
  final StackTrace? stackTrace;
  String text(BuildContext context);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Failure &&
        other.message == message &&
        other.stackTrace == stackTrace;
  }

  @override
  int get hashCode => message.hashCode ^ stackTrace.hashCode;
}

final class ConnectionFailure extends Failure {
  ConnectionFailure({super.stackTrace}) : super('internetError');

  @override
  String text(BuildContext context) {
    return i10n(context).errorsInternetError;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Failure &&
        other.message == message &&
        other.stackTrace == stackTrace;
  }

  @override
  int get hashCode => message.hashCode ^ stackTrace.hashCode;
}

typedef RepositoryResponse<T> = ({Failure? left, T? right});

extension Fold<T> on RepositoryResponse<T> {
  FutureOr fold(Function(Failure err) l, Function(T data) r) async {
    if (!success) {
      return await l(this.left!);
    }
    if (this.right != null) {
      return await r(this.right as T);
    }
  }

  bool get success => this.left == null;
}

RepositoryResponse<T> right<T>(T data) {
  return (left: null, right: data);
}

RepositoryResponse<T> left<T>(Failure failure) {
  return (left: failure, right: null);
}
