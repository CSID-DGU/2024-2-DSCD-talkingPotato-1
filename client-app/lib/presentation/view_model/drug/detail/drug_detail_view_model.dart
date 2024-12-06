import 'package:get/get.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/drug/read_drug_detail_condition.dart';
import 'package:wooahan/domain/condition/drug/read_drug_summary_condition.dart';
import 'package:wooahan/domain/entity/drug/drug_detail_state.dart';
import 'package:wooahan/domain/entity/drug/drug_summary_state.dart';
import 'package:wooahan/domain/usecase/drug/read_drug_detail_use_case.dart';
import 'package:wooahan/domain/usecase/drug/read_drug_summary_use_case.dart';

class DrugDetailViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* DI Fields -------------------------------------------- */
  /* ------------------------------------------------------ */
  late final int id;
  late final String type;

  late final ReadDrugSummaryUseCase _readDrugSummaryUseCase;
  late final ReadDrugDetailUseCase _readDrugDetailUseCase;

  /* ------------------------------------------------------ */
  /* Private Fields --------------------------------------- */
  /* ------------------------------------------------------ */
  late final RxBool _isLoading;

  late final Rx<DrugSummaryState> _drugSummary;
  late final Rx<DrugDetailState> _drugDetail;

  /* ------------------------------------------------------ */
  /* Public Fields ---------------------------------------- */
  /* ------------------------------------------------------ */

  bool get isLoading => _isLoading.value;

  DrugSummaryState get drugSummary => _drugSummary.value;
  DrugDetailState get drugDetail => _drugDetail.value;

  /* ------------------------------------------------------ */
  /* Method ----------------------------------------------- */
  /* ------------------------------------------------------ */
  @override
  void onInit() {
    id = int.parse(Get.parameters['id']!);
    type = Get.arguments['type'];

    _readDrugSummaryUseCase = Get.find<ReadDrugSummaryUseCase>();
    _readDrugDetailUseCase = Get.find<ReadDrugDetailUseCase>();

    _isLoading = true.obs;

    _drugSummary = DrugSummaryState.initial().obs;
    _drugDetail = DrugDetailState.initial().obs;

    super.onInit();
  }

  @override
  void onReady() async {
    _isLoading.value = true;

    await Future.wait([
      _fetchDrugBriefInformation(),
      _fetchDrugDetailInformation(),
    ]);

    _isLoading.value = false;

    super.onReady();
  }

  Future<void> _fetchDrugBriefInformation() async {
    StateWrapper<DrugSummaryState> result =
        await _readDrugSummaryUseCase.execute(
      ReadDrugSummaryCondition(
        drugId: id,
      ),
    );

    _drugSummary(result.data!);
  }

  Future<void> _fetchDrugDetailInformation() async {
    StateWrapper<DrugDetailState> result = await _readDrugDetailUseCase.execute(
      ReadDrugDetailCondition(
        drugId: id,
        type: type,
      ),
    );

    _drugDetail(result.data!);
  }
}
