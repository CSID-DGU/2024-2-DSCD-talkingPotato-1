import 'package:get/get.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/schedule/read_schedule_detail_list_condition.dart';
import 'package:wooahan/domain/entity/schedule/schedule_detail_state.dart';
import 'package:wooahan/domain/entity/schedule/schedule_summary_state.dart';
import 'package:wooahan/domain/usecase/schedule/read_schedule_detail_list_use_case.dart';
import 'package:wooahan/domain/usecase/schedule/read_schedule_summary_list_use_case.dart';

class MedicationViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* DI Fields -------------------------------------------- */
  /* ------------------------------------------------------ */
  late DateTime _selectedDate;
  late String _selectedTypeStr;

  late final ReadScheduleSummaryListUseCase _readScheduleSummaryListUseCase;
  late final ReadScheduleDetailListUseCase _readScheduleDetailListUseCase;

  /* ------------------------------------------------------ */
  /* Private Fields --------------------------------------- */
  /* ------------------------------------------------------ */
  late final RxBool _isLoading;

  late final RxList<ScheduleSummaryState> _scheduleSummaryList;
  late final RxList<ScheduleDetailState> _scheduleDetailList;

  /* ------------------------------------------------------ */
  /* Public Fields ---------------------------------------- */
  /* ------------------------------------------------------ */

  bool get isLoading => _isLoading.value;

  List<ScheduleSummaryState> get scheduleSummaryList => _scheduleSummaryList;
  List<ScheduleDetailState> get scheduleDetailList => _scheduleDetailList;

  /* ------------------------------------------------------ */
  /* Method ----------------------------------------------- */
  /* ------------------------------------------------------ */
  @override
  void onInit() {
    _selectedDate = DateTime.now();
    _selectedTypeStr = 'daily';

    _readScheduleDetailListUseCase = Get.find<ReadScheduleDetailListUseCase>();
    _readScheduleSummaryListUseCase =
        Get.find<ReadScheduleSummaryListUseCase>();

    _isLoading = true.obs;

    _scheduleSummaryList = <ScheduleSummaryState>[].obs;
    _scheduleDetailList = <ScheduleDetailState>[].obs;

    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();

    _isLoading.value = true;

    await Future.wait([
      _fetchScheduleSummaryList(),
      _fetchScheduleList(_selectedTypeStr),
    ]);

    _isLoading.value = false;
  }

  Future<void> onRefresh() async {
    _isLoading.value = true;

    await Future.wait([
      _fetchScheduleSummaryList(),
      _fetchScheduleList(_selectedTypeStr),
    ]);

    _isLoading.value = false;
  }

  Future<void> updateSelectedType(String typeStr) async {
    _selectedTypeStr = typeStr;

    _scheduleSummaryList.value = _scheduleSummaryList
        .map(
          (e) => e.copyWith(isNow: e.timeline == typeStr),
        )
        .toList();

    await _fetchScheduleList(typeStr);
  }

  void updateIsTakenInScheduleDetailList(String drugName) {
    int nextTakenAmount = _scheduleSummaryList
        .firstWhere(
          (e) => e.timeline == _selectedTypeStr,
        )
        .takenAmount;

    _scheduleDetailList.value = _scheduleDetailList.map(
      (e) {
        if (e.drugName == drugName) {
          bool nextIsTaken = !e.isTaken;

          if (nextIsTaken) {
            nextTakenAmount += 1;
          } else {
            nextTakenAmount -= 1;
          }

          return e.copyWith(isTaken: !e.isTaken);
        } else {
          return e;
        }
      },
    ).toList();

    _scheduleSummaryList.value = _scheduleSummaryList.map(
      (e) {
        if (e.timeline == _selectedTypeStr) {
          return e.copyWith(takenAmount: nextTakenAmount);
        } else {
          return e;
        }
      },
    ).toList();
  }

  Future<void> _fetchScheduleSummaryList() async {
    StateWrapper<List<ScheduleSummaryState>> result =
        await _readScheduleSummaryListUseCase.execute();

    _scheduleSummaryList.assignAll(result.data ?? []);
  }

  Future<void> _fetchScheduleList(String typeStr) async {
    _scheduleDetailList.clear();

    StateWrapper<List<ScheduleDetailState>> result =
        await _readScheduleDetailListUseCase.execute(
      ReadScheduleDetailListCondition(typeStr: typeStr.toUpperCase()),
    );

    _scheduleDetailList.assignAll(result.data ?? []);
  }
}
