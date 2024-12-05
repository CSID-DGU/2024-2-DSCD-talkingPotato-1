import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/schedule/create_schedule_condition.dart';
import 'package:wooahan/domain/condition/schedule/delete_schedule_condition.dart';
import 'package:wooahan/domain/condition/schedule/read_schedule_detail_list_condition.dart';
import 'package:wooahan/domain/entity/schedule/schedule_summary_state.dart';

abstract class ScheduleRepository {
  Future<StateWrapper<List<dynamic>>> readScheduleDetailList(
    ReadScheduleDetailListCondition condition,
  );

  Future<StateWrapper<List<ScheduleSummaryState>>> readScheduleSummaryList();

  Future<StateWrapper<void>> createSchedule(
    CreateScheduleCondition condition,
  );

  Future<StateWrapper<void>> deleteSchedule(
    DeleteScheduleCondition condition,
  );
}
