import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/analysis/analysis_document_condition.dart';
import 'package:wooahan/domain/condition/analysis/analysis_drug_bag_condition.dart';
import 'package:wooahan/domain/entity/drug/drug_summary_state.dart';

abstract class AnalysisRepository {
  Future<StateWrapper<List<DrugSummaryState>>> analysisDrugBag(
    AnalysisDrugBagCondition condition,
  );

  Future<StateWrapper<String>> analysisDocument(
    AnalysisDocumentCondition condition,
  );
}
