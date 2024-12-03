import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/drug/read_drug_summary_condition.dart';
import 'package:wooahan/domain/condition/schedule/read_schedule_detail_list_condition.dart';
import 'package:wooahan/domain/entity/drug/drug_summary_state.dart';
import 'package:wooahan/domain/entity/schedule/schedule_detail_state.dart';
import 'package:wooahan/domain/repository/drug/drug_repository.dart';
import 'package:wooahan/domain/repository/schedule/schedule_repository.dart';

class ReadScheduleDetailListUseCase extends BaseUseCase
    implements
        AsyncConditionUseCase<List<ScheduleDetailState>,
            ReadScheduleDetailListCondition> {
  late final ScheduleRepository _scheduleRepository;
  late final DrugRepository _drugRepository;

  @override
  void onInit() {
    _drugRepository = Get.find<DrugRepository>();
    _scheduleRepository = Get.find<ScheduleRepository>();

    super.onInit();
  }

  @override
  Future<StateWrapper<List<ScheduleDetailState>>> execute(
    ReadScheduleDetailListCondition condition,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return StateWrapper(success: true, data: [
      ScheduleDetailState(
        isTaken: false,
        drugType: 'CUSTOM',
        drugName: '홍삼',
      ),
      ScheduleDetailState(
        isTaken: true,
        drugId: 9850,
        drugType: 'MEDICINE',
        drugName: '나르펜정400밀리그램',
        drugClassificationOrManufacturer: '해열.진통.소염제',
        drugImageUrl:
            'https://kr.object.ncloudstorage.com/viewpam/drugs/images/e46bae94-be91-499f-8d12-102ebad52a54.jpg',
      ),
      ScheduleDetailState(
        isTaken: true,
        drugId: 9737,
        drugType: 'MEDICINE',
        drugName: '동화디트로판정',
        drugClassificationOrManufacturer: '자율신경제',
        drugImageUrl:
            'https://kr.object.ncloudstorage.com/viewpam/drugs/images/f5a01421-e87d-48c2-a4a3-82f3494ff7ea.jpg',
      ),
      ScheduleDetailState(
        isTaken: true,
        drugId: 1,
        drugType: 'VITAMIN',
        drugName: '+프리맥',
        drugClassificationOrManufacturer: '코스맥스바이오(주)',
        drugImageUrl:
            'https://kr.object.ncloudstorage.com/viewpam/drugs/images/a01d3156-1ea9-4003-a2be-3d6524cffa4e.jpg',
      ),
    ]);

    StateWrapper<List<dynamic>> beforeState =
        await _scheduleRepository.readScheduleDetailList(condition);

    if (!beforeState.success) {
      return StateWrapper(success: false, message: beforeState.message);
    }

    List<int> drugIdList =
        beforeState.data!.map((e) => e['drug_id'] as int).toList();

    List<DrugSummaryState> drugSummaryList = [];

    for (int drugId in drugIdList) {
      StateWrapper<DrugSummaryState> drugSummaryState = await _drugRepository
          .readDrugSummary(ReadDrugSummaryCondition(drugId: drugId));

      if (!drugSummaryState.success) {
        return StateWrapper(success: false, message: "조회 중 오류가 생겼습니다.");
      }

      drugSummaryList.add(drugSummaryState.data!);
    }

    return StateWrapper(
      success: true,
      data: beforeState.data!.map((e) {
        DrugSummaryState drugSummary =
            drugSummaryList.firstWhere((element) => element.id == e['drug_id']);

        return ScheduleDetailState(
          isTaken: e['is_taken'] as bool,
          drugId: e['drug_id'] as int,
          drugType: drugSummary.type,
          drugName: drugSummary.name,
          drugClassificationOrManufacturer:
              drugSummary.classificationOrManufacturer,
          drugImageUrl: drugSummary.imageUrl,
        );
      }).toList(),
    );
  }
}
