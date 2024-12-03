import 'package:get/get.dart';
import 'package:wooahan/core/provider/base_connect.dart';
import 'package:wooahan/core/wrapper/response_wrapper.dart';
import 'package:wooahan/data/provider/schedule/schedule_remote_provider.dart';

class ScheduleRemoteProviderImpl extends BaseConnect
    implements ScheduleRemoteProvider {
  @override
  Future<ResponseWrapper> getScheduleDetailList({
    required String timeStr,
  }) async {
    Response response = await get(
      '/api/v1/schedules',
      query: {
        'time': timeStr,
      },
      headers: BaseConnect.useBearerToken,
    );

    return ResponseWrapper.fromJson(response.body);
  }

  @override
  Future<ResponseWrapper> getScheduleSummaryList() async {
    Response response = await get(
      '/api/v1/schedules/summary',
      headers: BaseConnect.useBearerToken,
    );

    return ResponseWrapper.fromJson(response.body);
  }
}
