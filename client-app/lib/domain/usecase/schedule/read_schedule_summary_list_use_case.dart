import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_no_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/entity/schedule/schedule_summary_state.dart';
import 'package:wooahan/domain/repository/schedule/schedule_repository.dart';

class ReadScheduleSummaryListUseCase extends BaseUseCase
    implements AsyncNoConditionUseCase<List<ScheduleSummaryState>> {
  late final ScheduleRepository _scheduleRepository;

  @override
  void onInit() {
    _scheduleRepository = Get.find<ScheduleRepository>();

    super.onInit();
  }

  @override
  Future<StateWrapper<List<ScheduleSummaryState>>> execute() async {
    return await _scheduleRepository.readScheduleSummaryList();
  }
}
