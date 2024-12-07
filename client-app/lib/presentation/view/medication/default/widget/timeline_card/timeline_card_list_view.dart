import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/presentation/view/medication/default/widget/timeline_card/component/timeline_card_item_view.dart';
import 'package:wooahan/presentation/view_model/medication/default/medication_view_model.dart';

class TimelineCardListView extends BaseWidget<MedicationViewModel> {
  const TimelineCardListView({super.key});

  @override
  Widget buildView(BuildContext context) {
    return SizedBox(
      height: ((Get.width - 100) / 4) * 2.3,
      child: Obx(
        () => ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: viewModel.scheduleSummaryList.length,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          separatorBuilder: (context, index) => const SizedBox(width: 20),
          itemBuilder: (context, index) {
            return TimelineCardItemView(
              state: viewModel.scheduleSummaryList[index],
              onTap: () {
                viewModel.updateSelectedType(
                    viewModel.scheduleSummaryList[index].timeline);
              },
            );
          },
        ),
      ),
    );
  }
}
