import 'package:flutter/material.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/domain/entity/schedule_overview_state.dart';
import 'package:wooahan/presentation/view/medication_management/widget/schedule_card/component/schedule_card_item_view.dart';
import 'package:wooahan/presentation/view_model/medication_management/medication_management_view_model.dart';

class ScheduleCardListView extends BaseWidget<MedicationManagementViewModel> {
  const ScheduleCardListView({super.key});

  @override
  Widget buildView(BuildContext context) {
    List<ScheduleOverviewState> items = [
      ScheduleOverviewState(
        id: 1,
        takenAt: '2024-10-29',
        isTaken: false,
        drugType: 'CUSTOM',
        drugName: '홍삼',
      ),
      ScheduleOverviewState(
        id: 2,
        takenAt: '2024-10-29',
        isTaken: true,
        drugId: 9850,
        drugType: 'OTC_MEDICINE',
        drugName: '나르펜정400밀리그램',
        drugClassificationOrManufacturer: '해열.진통.소염제',
        drugImageUrl:
            'https://kr.object.ncloudstorage.com/viewpam/drugs/images/e46bae94-be91-499f-8d12-102ebad52a54.jpg',
      ),
      ScheduleOverviewState(
        id: 3,
        takenAt: '2024-10-29',
        isTaken: true,
        drugId: 9737,
        drugType: 'ETC_MEDICINE',
        drugName: '동화디트로판정',
        drugClassificationOrManufacturer: '자율신경제',
        drugImageUrl:
            'https://kr.object.ncloudstorage.com/viewpam/drugs/images/f5a01421-e87d-48c2-a4a3-82f3494ff7ea.jpg',
      ),
      ScheduleOverviewState(
        id: 4,
        takenAt: '2024-10-29',
        isTaken: true,
        drugId: 1,
        drugType: 'VITAMIN',
        drugName: '+프리맥',
        drugClassificationOrManufacturer: '코스맥스바이오(주)',
        drugImageUrl:
            'https://kr.object.ncloudstorage.com/viewpam/drugs/images/a01d3156-1ea9-4003-a2be-3d6524cffa4e.jpg',
      ),
      ScheduleOverviewState(
        id: 4,
        takenAt: '2024-10-29',
        isTaken: true,
        drugId: 1,
        drugType: 'VITAMIN',
        drugName: '+프리맥',
        drugClassificationOrManufacturer: '코스맥스바이오(주)',
        drugImageUrl:
            'https://kr.object.ncloudstorage.com/viewpam/drugs/images/a01d3156-1ea9-4003-a2be-3d6524cffa4e.jpg',
      ),
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: items.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 20);
      },
      itemBuilder: (context, index) {
        return ScheduleCardItemView(
          state: items[index],
          onTapContext: () {},
          onTapCheckbox: () {},
        );
      },
    );
  }
}
