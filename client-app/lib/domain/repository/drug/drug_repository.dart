import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/drug/read_drug_brief_list_condition.dart';
import 'package:wooahan/domain/condition/drug/read_drug_detail_condition.dart';
import 'package:wooahan/domain/condition/drug/read_drug_summary_condition.dart';
import 'package:wooahan/domain/entity/drug/drug_brief_state.dart';
import 'package:wooahan/domain/entity/drug/drug_detail_state.dart';
import 'package:wooahan/domain/entity/drug/drug_summary_state.dart';

abstract class DrugRepository {
  Future<StateWrapper<List<DrugBriefState>>> readDrugBriefList(
    ReadDrugBriefListCondition condition,
  );

  Future<StateWrapper<DrugSummaryState>> readDrugSummary(
    ReadDrugSummaryCondition condition,
  );

  Future<StateWrapper<DrugDetailState>> readDrugDetail(
    ReadDrugDetailCondition condition,
  );
}
