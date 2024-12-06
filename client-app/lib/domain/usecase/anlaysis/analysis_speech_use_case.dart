import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/analysis/analysis_speech_condition.dart';
import 'package:wooahan/domain/repository/analysis/analysis_repository.dart';

class AnalysisSpeechUseCase extends BaseUseCase
    implements AsyncConditionUseCase<String, AnalysisSpeechCondition> {
  late final AnalysisRepository _analysisRepository;

  @override
  void onInit() {
    _analysisRepository = Get.find<AnalysisRepository>();

    super.onInit();
  }

  @override
  Future<StateWrapper<String>> execute(
    AnalysisSpeechCondition condition,
  ) async {
    // 2~3초 대기
    await Future.delayed(const Duration(seconds: 3));

    return StateWrapper(success: true, data: "${condition.text} 분석 완료");

    return await _analysisRepository.analysisSpeech(condition);
  }
}
