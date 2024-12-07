import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/app_routes.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_screen.dart';
import 'package:wooahan/presentation/view/medication/default/widget/schedule_card/schedule_card_list_view.dart';
import 'package:wooahan/presentation/view/medication/default/widget/schedule_header/schedule_header_view.dart';
import 'package:wooahan/presentation/view/medication/default/widget/timeline_card/timeline_card_list_view.dart';
import 'package:wooahan/presentation/view_model/medication/default/medication_view_model.dart';
import 'package:wooahan/presentation/widget/common/appbar/text_default_app_bar.dart';

class MedicationScreen extends BaseScreen<MedicationViewModel> {
  const MedicationScreen({super.key});

  @override
  Color? get screenBackgroundColor => ColorSystem.neutral.shade100;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return TextDefaultAppBar(
      preferredSize: const Size.fromHeight(64),
      title: '복약 관리',
      actions: [
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.MEDICATION + AppRoutes.EDITING_PATH);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.edit_note_outlined,
                color: ColorSystem.secondary.shade800,
                size: 28,
              ),
              Text(
                '수정하기',
                style: FontSystem.Sub3.copyWith(
                  color: ColorSystem.secondary.shade800,
                  fontSize: 14,
                  height: 1.0,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return RefreshIndicator(
      onRefresh: viewModel.onRefresh,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  color: ColorSystem.neutral.shade100,
                  child: const Column(
                    children: [
                      SizedBox(height: 20),
                      TimelineCardListView(),
                      SizedBox(height: 32),
                      ScheduleHeaderView(),
                      SizedBox(height: 32),
                      ScheduleCardListView(),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
