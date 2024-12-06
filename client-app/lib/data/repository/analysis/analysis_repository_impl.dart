import 'package:get/get.dart';
import 'package:wooahan/core/wrapper/response_wrapper.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/data/provider/analysis/analysis_remote_provider.dart';
import 'package:wooahan/domain/condition/analysis/analysis_document_condition.dart';
import 'package:wooahan/domain/condition/analysis/analysis_drug_bag_condition.dart';
import 'package:wooahan/domain/entity/drug/drug_summary_state.dart';
import 'package:wooahan/domain/repository/analysis/analysis_repository.dart';

class AnalysisRepositoryImpl extends GetxService implements AnalysisRepository {
  late final AnalysisRemoteProvider _remoteProvider;

  @override
  void onInit() {
    super.onInit();

    _remoteProvider = Get.find<AnalysisRemoteProvider>();
  }

  @override
  Future<StateWrapper<List<DrugSummaryState>>> analysisDrugBag(
    AnalysisDrugBagCondition condition,
  ) async {
    ResponseWrapper response = await _remoteProvider.postDrugBag(
      image: condition.file,
    );

    if (response.isFailure) {
      return StateWrapper(
        success: response.success,
        message: response.message,
      );
    }

    List<DrugSummaryState> drugSummaryList = response.data!['drugs']
        .map<DrugSummaryState>(
          (drug) => DrugSummaryState.fromJson(drug),
        )
        .toList();

    return StateWrapper(
      success: response.success,
      data: drugSummaryList,
    );
  }

  @override
  Future<StateWrapper<String>> analysisDocument(
    AnalysisDocumentCondition condition,
  ) async {
    ResponseWrapper response = await _remoteProvider.postDocument(
      image: condition.file,
    );

    if (response.isFailure) {
      return StateWrapper(
        success: response.success,
        message: response.message,
      );
    }

    return StateWrapper(
      success: response.success,
      data: response.data!['result'],
    );
  }
}
