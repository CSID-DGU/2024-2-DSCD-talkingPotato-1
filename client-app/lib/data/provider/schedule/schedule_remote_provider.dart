import 'package:wooahan/core/wrapper/response_wrapper.dart';

abstract class ScheduleRemoteProvider {
  Future<ResponseWrapper> getScheduleDetailList({
    required String timeStr,
  });

  Future<ResponseWrapper> getScheduleSummaryList();

  Future<ResponseWrapper> postSchedule({
    required int drugId,
    required String time,
    required String date,
  });

  Future<ResponseWrapper> deleteSchedule({
    required String drugId,
    required String time,
    required String date,
  });
}
