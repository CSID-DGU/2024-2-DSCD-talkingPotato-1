import 'package:get/get.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/schedule/create_schedule_condition.dart';
import 'package:wooahan/domain/condition/schedule/delete_schedule_condition.dart';
import 'package:wooahan/domain/condition/schedule/read_schedule_detail_list_condition.dart';
import 'package:wooahan/domain/entity/schedule/schedule_detail_state.dart';
import 'package:wooahan/domain/entity/schedule/schedule_summary_state.dart';
import 'package:wooahan/domain/usecase/schedule/create_schedule_use_case.dart';
import 'package:wooahan/domain/usecase/schedule/delete_schedule_use_case.dart';
import 'package:wooahan/domain/usecase/schedule/read_schedule_detail_list_use_case.dart';
import 'package:wooahan/domain/usecase/schedule/read_schedule_summary_list_use_case.dart';

class MedicationViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* DI Fields -------------------------------------------- */
  /* ------------------------------------------------------ */
  late DateTime _currentAppDateTime;

  late final ReadScheduleSummaryListUseCase _readScheduleSummaryListUseCase;
  late final ReadScheduleDetailListUseCase _readScheduleDetailListUseCase;
  late final CreateScheduleUseCase _createScheduleUseCase;
  late final DeleteScheduleUseCase _deleteScheduleUseCase;

  /* ------------------------------------------------------ */
  /* Private Fields --------------------------------------- */
  /* ------------------------------------------------------ */
  late final RxString _selectedTimeline;

  late final RxBool _isInitLoading;
  late final RxBool _isMoreLoading;

  late final RxList<ScheduleSummaryState> _scheduleSummaryList;
  late final RxList<ScheduleDetailState> _scheduleDetailList;

  /* ------------------------------------------------------ */
  /* Public Fields ---------------------------------------- */
  /* ------------------------------------------------------ */
  String get selectedTimeline => _selectedTimeline.value;

  bool get isLoading => _isInitLoading.value;
  bool get isMoreLoading => _isMoreLoading.value;

  List<ScheduleSummaryState> get scheduleSummaryList => _scheduleSummaryList;
  List<ScheduleDetailState> get scheduleDetailList => _scheduleDetailList;

  /* ------------------------------------------------------ */
  /* Method ----------------------------------------------- */
  /* ------------------------------------------------------ */
  @override
  void onInit() {
    _currentAppDateTime = DateTime.now();
    _selectedTimeline = 'daily'.obs;

    _readScheduleDetailListUseCase = Get.find<ReadScheduleDetailListUseCase>();
    _readScheduleSummaryListUseCase =
        Get.find<ReadScheduleSummaryListUseCase>();
    _createScheduleUseCase = Get.find<CreateScheduleUseCase>();
    _deleteScheduleUseCase = Get.find<DeleteScheduleUseCase>();

    _isInitLoading = true.obs;
    _isMoreLoading = false.obs;

    _scheduleSummaryList = <ScheduleSummaryState>[].obs;
    _scheduleDetailList = <ScheduleDetailState>[].obs;

    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();

    _isInitLoading.value = true;

    await Future.wait([
      _fetchScheduleSummaryList(),
      _fetchScheduleList(_selectedTimeline.value),
    ]);

    _isInitLoading.value = false;
  }

  Future<void> onRefresh() async {
    _isInitLoading.value = true;

    _currentAppDateTime = DateTime.now();

    await Future.wait([
      _fetchScheduleSummaryList(),
      _fetchScheduleList(_selectedTimeline.value),
    ]);

    _isInitLoading.value = false;
  }

  Future<void> _fetchScheduleSummaryList() async {
    StateWrapper<List<ScheduleSummaryState>> result =
        await _readScheduleSummaryListUseCase.execute();

    _scheduleSummaryList.assignAll(result.data!.map(
      (e) => e.copyWith(
        isNow: e.timeline == _selectedTimeline.value,
      ),
    ));
  }

  Future<void> _fetchScheduleList(String typeStr) async {
    _isMoreLoading.value = true;

    _scheduleDetailList.clear();

    StateWrapper<List<ScheduleDetailState>> result =
        await _readScheduleDetailListUseCase.execute(
      ReadScheduleDetailListCondition(typeStr: typeStr.toUpperCase()),
    );

    _scheduleDetailList.assignAll(result.data ?? []);

    _isMoreLoading.value = false;
  }

  Future<void> updateSelectedType(String typeStr) async {
    _selectedTimeline.value = typeStr;

    _scheduleSummaryList.value = _scheduleSummaryList
        .map(
          (e) => e.copyWith(isNow: e.timeline == typeStr),
        )
        .toList();

    await _fetchScheduleList(typeStr);
  }

  Future<bool> updateIsTakenInScheduleDetail(int index) async {
    ScheduleDetailState state = _scheduleDetailList[index];

    bool beforeIsTaken = state.isTaken;
    bool afterIsTaken = !state.isTaken;

    StateWrapper<void> stateWrapper;

    if (beforeIsTaken) {
      stateWrapper = await _deleteScheduleUseCase.execute(
        DeleteScheduleCondition(
          drugId: state.drugId,
          time: _selectedTimeline.value,
          currentAppTime: _currentAppDateTime,
        ),
      );
    } else {
      stateWrapper = await _createScheduleUseCase.execute(
        CreateScheduleCondition(
          drugId: state.drugId,
          time: _selectedTimeline.value,
          currentAppTime: _currentAppDateTime,
        ),
      );
    }

    if (!stateWrapper.success) {
      return false;
    }

    _scheduleSummaryList.value = _scheduleSummaryList.map(
      (e) {
        if (e.timeline == _selectedTimeline.value) {
          return e.copyWith(
            takenAmount: e.takenAmount + (afterIsTaken ? 1 : -1),
          );
        } else {
          return e;
        }
      },
    ).toList();

    _scheduleDetailList.value = _scheduleDetailList.map(
      (e) {
        if (e.drugId == state.drugId) {
          return e.copyWith(isTaken: afterIsTaken);
        } else {
          return e;
        }
      },
    ).toList();

    return true;
  }
}
