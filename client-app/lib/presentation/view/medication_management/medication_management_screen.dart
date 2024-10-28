import 'package:flutter/material.dart';
import 'package:wooahan/core/screen/base_screen.dart';
import 'package:wooahan/presentation/view/medication_management/widget/schedule_card/schedule_card_list_view.dart';
import 'package:wooahan/presentation/view/medication_management/widget/schedule_header/schedule_header_view.dart';
import 'package:wooahan/presentation/view/medication_management/widget/timeline_card/timeline_card_list_view.dart';
import 'package:wooahan/presentation/view_model/medication_management/medication_management_view_model.dart';

class MedicationManagementScreen
    extends BaseScreen<MedicationManagementViewModel> {
  const MedicationManagementScreen({super.key});

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
