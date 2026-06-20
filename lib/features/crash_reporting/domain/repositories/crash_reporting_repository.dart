abstract class CrashReportingRepository {
  Future<void> recordError(dynamic error, StackTrace? stack);
  Future<void> log(String message);
}
