import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/analysis/analysis_drug_bag_condition.dart';
import 'package:wooahan/domain/entity/drug/drug_summary_state.dart';
import 'package:wooahan/domain/repository/analysis/analysis_repository.dart';

class AnalysisDrugBagUseCase extends BaseUseCase
    implements
        AsyncConditionUseCase<List<DrugSummaryState>,
            AnalysisDrugBagCondition> {
  late final AnalysisRepository _analysisRepository;

  @override
  void onInit() {
    _analysisRepository = Get.find<AnalysisRepository>();

    super.onInit();
  }

  @override
  Future<StateWrapper<List<DrugSummaryState>>> execute(
    AnalysisDrugBagCondition condition,
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    return StateWrapper(
      success: true,
      data: [
        DrugSummaryState(
          id: 9850,
          type: 'MEDICINE',
          name: '나르펜정400밀리그램',
          classificationOrManufacturer: '해열.진통.소염제',
          imageUrl:
              'https://kr.object.ncloudstorage.com/viewpam/drugs/images/e46bae94-be91-499f-8d12-102ebad52a54.jpg',
        ),
        DrugSummaryState(
          id: 9737,
          type: 'MEDICINE',
          name: '동화디트로판정',
          classificationOrManufacturer: '자율신경제',
          imageUrl:
              'https://kr.object.ncloudstorage.com/viewpam/drugs/images/f5a01421-e87d-48c2-a4a3-82f3494ff7ea.jpg',
        ),
        DrugSummaryState(
          id: 1,
          type: 'VITAMIN',
          name: '+프리맥',
          classificationOrManufacturer: '코스맥스바이오(주)',
          imageUrl:
              'https://kr.object.ncloudstorage.com/viewpam/drugs/images/a01d3156-1ea9-4003-a2be-3d6524cffa4e.jpg',
        ),
      ],
    );

    return await _analysisRepository.analysisDrugBag(condition);
  }
}
