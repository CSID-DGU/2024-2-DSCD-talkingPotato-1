import 'package:get/get.dart';
import 'package:wooahan/core/wrapper/response_wrapper.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/data/provider/drug/drug_remote_provider.dart';
import 'package:wooahan/domain/condition/drug/read_drug_brief_list_condition.dart';
import 'package:wooahan/domain/condition/drug/read_drug_detail_condition.dart';
import 'package:wooahan/domain/condition/drug/read_drug_summary_condition.dart';
import 'package:wooahan/domain/entity/drug/drug_brief_state.dart';
import 'package:wooahan/domain/entity/drug/drug_detail_state.dart';
import 'package:wooahan/domain/entity/drug/drug_summary_state.dart';
import 'package:wooahan/domain/repository/drug/drug_repository.dart';

class DrugRepositoryImpl extends GetxService implements DrugRepository {
  late final DrugRemoteProvider _remoteProvider;

  @override
  void onInit() {
    _remoteProvider = Get.find<DrugRemoteProvider>();

    super.onInit();
  }

  @override
  Future<StateWrapper<List<DrugBriefState>>> readDrugBriefList(
    ReadDrugBriefListCondition condition,
  ) async {
    ResponseWrapper response = await _remoteProvider.getDrugBriefList(
      query: condition.searchTerm,
      page: condition.page.toString(),
      size: condition.size.toString(),
    );

    List<DrugBriefState> briefDrugs = [];

    if (response.success) {
      List<dynamic> data = response.data!['drugs'];
      briefDrugs = data.map((e) => DrugBriefState.fromJson(e)).toList();
    }

    return StateWrapper(
      success: response.success,
      message: response.message,
      data: briefDrugs,
    );
  }

  @override
  Future<StateWrapper<DrugDetailState>> readDrugDetail(
    ReadDrugDetailCondition condition,
  ) async {
    ResponseWrapper response;

    if (condition.type == 'MEDICINE') {
      response = await _remoteProvider.getMedicineDetail(
        id: condition.drugId,
      );
    } else if (condition.type == 'VITAMIN') {
      response = await _remoteProvider.getVitaminDetail(
        id: condition.drugId,
      );
    } else {
      throw Exception('Invalid drug type');
    }

    DrugDetailState? state;

    if (response.success) {
      state = DrugDetailState.fromJson(response.data!);
    }

    return StateWrapper.fromResponseAndState(response, state!);
  }

  @override
  Future<StateWrapper<DrugSummaryState>> readDrugSummary(
    ReadDrugSummaryCondition condition,
  ) async {
    ResponseWrapper response = await _remoteProvider.getDrugSummary(
      id: condition.drugId,
    );

    DrugSummaryState? state;

    if (response.success) {
      state = DrugSummaryState.fromJson(response.data!);
    }

    return StateWrapper(
      success: response.success,
      message: response.message,
      data: state,
    );
  }
}
