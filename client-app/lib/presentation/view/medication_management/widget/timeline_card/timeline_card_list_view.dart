import 'package:flutter/material.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/domain/entity/schedule_chunk_state.dart';
import 'package:wooahan/presentation/view/medication_management/widget/timeline_card/component/timeline_card_item_view.dart';
import 'package:wooahan/presentation/view_model/medication_management/medication_management_view_model.dart';

class TimelineCardListView extends BaseWidget<MedicationManagementViewModel> {
  const TimelineCardListView({super.key});

  @override
  Widget buildView(BuildContext context) {
    List<ScheduleChunkState> items = [
      ScheduleChunkState(
        timeline: 'breakfast',
        takenAmount: 3,
        totalAmount: 4,
        isNow: false,
      ),
      ScheduleChunkState(
        timeline: 'lunch',
        takenAmount: 2,
        totalAmount: 3,
        isNow: false,
      ),
      ScheduleChunkState(
        timeline: 'dinner',
        takenAmount: 1,
        totalAmount: 2,
        isNow: true,
      ),
      ScheduleChunkState(
        timeline: 'daily',
        takenAmount: 0,
        totalAmount: 1,
        isNow: false,
      ),
    ];

    return SizedBox(
      height: 160,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        separatorBuilder: (context, index) => const SizedBox(width: 20),
        itemBuilder: (context, index) {
          return TimelineCardItemView(
            state: items[index],
            onTap: () {},
          );
        },
      ),
    );
  }
}
