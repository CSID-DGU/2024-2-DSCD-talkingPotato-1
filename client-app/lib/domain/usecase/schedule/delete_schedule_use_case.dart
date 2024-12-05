import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/schedule/delete_schedule_condition.dart';
import 'package:wooahan/domain/repository/schedule/schedule_repository.dart';

class DeleteScheduleUseCase extends BaseUseCase
    implements AsyncConditionUseCase<void, DeleteScheduleCondition> {
  late final ScheduleRepository _scheduleRepository;

  @override
  void onInit() {
    _scheduleRepository = Get.find<ScheduleRepository>();

    super.onInit();
  }

  @override
  Future<StateWrapper<void>> execute(
    DeleteScheduleCondition condition,
  ) async {
    final result = await _scheduleRepository.deleteSchedule(condition);

    return result;
  }
}
