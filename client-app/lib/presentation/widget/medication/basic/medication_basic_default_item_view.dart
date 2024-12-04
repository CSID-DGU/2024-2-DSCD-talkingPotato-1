import 'package:flutter/material.dart';
import 'package:wooahan/domain/entity/medication/medication_state.dart';

class MedicationBasicDefaultItemView extends StatelessWidget {
  const MedicationBasicDefaultItemView({
    super.key,
    required this.state,
    required this.onTapBreakfast,
    required this.onTapLunch,
    required this.onTapDinner,
    required this.onTapDaily,
  });

  final MedicationState state;
  final VoidCallback onTapBreakfast;
  final VoidCallback onTapLunch;
  final VoidCallback onTapDinner;
  final VoidCallback onTapDaily;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
