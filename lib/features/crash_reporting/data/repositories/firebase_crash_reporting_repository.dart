import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/crash_reporting_repository.dart';

@LazySingleton(as: CrashReportingRepository)
class FirebaseCrashReportingRepository implements CrashReportingRepository {
  FirebaseCrashlytics? get _crashlytics =>
      Firebase.apps.isNotEmpty ? FirebaseCrashlytics.instance : null;

  @override
  Future<void> recordError(dynamic error, StackTrace? stack) async {
    final crashlytics = _crashlytics;
    if (crashlytics != null) {
      await crashlytics.recordError(error, stack);
    } else {
      debugPrint('[Stub Crashlytics] Error recorded: $error');
      if (stack != null) {
        debugPrint('[Stub Crashlytics] Stack: $stack');
      }
    }
  }

  @override
  Future<void> log(String message) async {
    final crashlytics = _crashlytics;
    if (crashlytics != null) {
      await crashlytics.log(message);
    } else {
      debugPrint('[Stub Crashlytics] log: $message');
    }
  }
}
