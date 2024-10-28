import 'package:flutter/material.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_screen.dart';
import 'package:wooahan/presentation/view_model/medication_management/medication_management_view_model.dart';

class MedicationManagementScreen
    extends BaseScreen<MedicationManagementViewModel> {
  const MedicationManagementScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return const Center(
      child: Text(
        'Medication ManagementScreen',
        style: FontSystem.Sub2,
      ),
    );
  }
}
