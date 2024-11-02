import 'package:flutter/material.dart';
import 'package:wooahan/app/utility/log_util.dart';
import 'package:wooahan/core/screen/base_screen.dart';
import 'package:wooahan/presentation/view/medication_management/widget/schedule_card/schedule_card_list_view.dart';
import 'package:wooahan/presentation/view/medication_management/widget/schedule_header/schedule_header_view.dart';
import 'package:wooahan/presentation/view/medication_management/widget/timeline_card/timeline_card_list_view.dart';
import 'package:wooahan/presentation/view_model/medication_management/medication_management_view_model.dart';
import 'package:wooahan/presentation/widget/appbar/text_default_app_bar.dart';

class MedicationManagementScreen
    extends BaseScreen<MedicationManagementViewModel> {
  const MedicationManagementScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return TextDefaultAppBar(
      preferredSize: const Size.fromHeight(64),
      title: '복약 관리',
      actions: [
        GestureDetector(
          onTap: () {
            LogUtil.info('Edit button taped');
          },
          child: const Icon(
            Icons.edit_note_outlined,
            size: 28,
          ),
        ),
      ],
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20),
          TimelineCardListView(),
          SizedBox(height: 32),
          ScheduleHeaderView(),
          SizedBox(height: 32),
          ScheduleCardListView(),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}
