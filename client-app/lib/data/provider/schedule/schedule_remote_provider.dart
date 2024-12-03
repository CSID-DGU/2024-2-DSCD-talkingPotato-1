import 'package:wooahan/core/wrapper/response_wrapper.dart';

abstract class ScheduleRemoteProvider {
  Future<ResponseWrapper> getScheduleDetailList({
    required String timeStr,
  });

  Future<ResponseWrapper> getScheduleSummaryList();
}
