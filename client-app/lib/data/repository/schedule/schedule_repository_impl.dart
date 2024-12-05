import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wooahan/core/wrapper/response_wrapper.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/data/provider/schedule/schedule_remote_provider.dart';
import 'package:wooahan/domain/condition/schedule/create_schedule_condition.dart';
import 'package:wooahan/domain/condition/schedule/delete_schedule_condition.dart';
import 'package:wooahan/domain/condition/schedule/read_schedule_detail_list_condition.dart';
import 'package:wooahan/domain/entity/schedule/schedule_summary_state.dart';
import 'package:wooahan/domain/repository/schedule/schedule_repository.dart';

class ScheduleRepositoryImpl extends GetxService implements ScheduleRepository {
  late final ScheduleRemoteProvider _scheduleRemoteProvider;

  @override
  void onInit() {
    _scheduleRemoteProvider = Get.find<ScheduleRemoteProvider>();

    super.onInit();
  }

  @override
  Future<StateWrapper<List<dynamic>>> readScheduleDetailList(
    ReadScheduleDetailListCondition condition,
  ) async {
    ResponseWrapper response =
        await _scheduleRemoteProvider.getScheduleDetailList(
      timeStr: condition.typeStr,
    );

    if (!response.success) {
      return StateWrapper(
        success: response.success,
        message: response.message,
      );
    }

    return StateWrapper(
      success: response.success,
      message: response.message,
      data: response.data!['drugs'],
    );
  }

  @override
  Future<StateWrapper<List<ScheduleSummaryState>>>
      readScheduleSummaryList() async {
    ResponseWrapper response =
        await _scheduleRemoteProvider.getScheduleSummaryList();

    if (!response.success) {
      return StateWrapper(
        success: response.success,
        message: response.message,
      );
    }

    List<String> timeline = ['breakfast', 'lunch', 'dinner', 'daily'];
    List<ScheduleSummaryState> scheduleSummaryList = [];

    for (String element in timeline) {
      scheduleSummaryList.add(ScheduleSummaryState(
        timeline: element,
        takenAmount: response.data![element]['takenDrugCount'],
        totalAmount: response.data![element]['totalDrugCount'],
        isNow: 'daily' == element,
      ));
    }

    return StateWrapper(
      success: response.success,
      message: response.message,
      data: scheduleSummaryList,
    );
  }

  @override
  Future<StateWrapper<void>> createSchedule(
    CreateScheduleCondition condition,
  ) async {
    String dateStr = DateFormat('yyyy-MM-dd').format(condition.currentAppTime);

    ResponseWrapper response = await _scheduleRemoteProvider.postSchedule(
      drugId: condition.drugId,
      time: condition.time.toUpperCase(),
      date: dateStr,
    );

    return StateWrapper(
      success: response.success,
      message: response.message,
    );
  }

  @override
  Future<StateWrapper<void>> deleteSchedule(
    DeleteScheduleCondition condition,
  ) async {
    String dateStr = DateFormat('yyyy-MM-dd').format(condition.currentAppTime);

    ResponseWrapper response = await _scheduleRemoteProvider.deleteSchedule(
      drugId: condition.drugId.toString(),
      time: condition.time.toUpperCase(),
      date: dateStr,
    );

    return StateWrapper(
      success: response.success,
      message: response.message,
    );
  }
}
