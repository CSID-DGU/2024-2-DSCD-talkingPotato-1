import 'package:get/get.dart';
import 'package:wooahan/domain/usecase/schedule/create_schedule_use_case.dart';
import 'package:wooahan/domain/usecase/schedule/delete_schedule_use_case.dart';
import 'package:wooahan/domain/usecase/schedule/read_schedule_detail_list_use_case.dart';
import 'package:wooahan/domain/usecase/schedule/read_schedule_summary_list_use_case.dart';
import 'package:wooahan/presentation/view_model/medication/default/medication_view_model.dart';

class MedicationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReadScheduleDetailListUseCase>(
      () => ReadScheduleDetailListUseCase(),
    );
    Get.lazyPut<ReadScheduleSummaryListUseCase>(
      () => ReadScheduleSummaryListUseCase(),
    );
    Get.lazyPut<CreateScheduleUseCase>(
      () => CreateScheduleUseCase(),
    );
    Get.lazyPut<DeleteScheduleUseCase>(
      () => DeleteScheduleUseCase(),
    );

    Get.lazyPut<MedicationViewModel>(
      () => MedicationViewModel(),
    );
  }
}
