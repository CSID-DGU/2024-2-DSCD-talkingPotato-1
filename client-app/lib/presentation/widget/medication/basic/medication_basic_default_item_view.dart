import 'package:flutter/material.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/domain/entity/medication/medication_state.dart';
import 'package:wooahan/presentation/widget/common/image/network_image_view.dart';
import 'package:wooahan/presentation/widget/common/image/svg_image_view.dart';

class MedicationBasicDefaultItemView extends StatelessWidget {
  const MedicationBasicDefaultItemView({
    super.key,
    required this.state,
    required this.onLongPress,
    required this.onTapBreakfast,
    required this.onTapLunch,
    required this.onTapDinner,
    required this.onTapDaily,
  });

  final MedicationState state;
  final VoidCallback onLongPress;
  final VoidCallback onTapBreakfast;
  final VoidCallback onTapLunch;
  final VoidCallback onTapDinner;
  final VoidCallback onTapDaily;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: Container(
        height: 340,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: ColorSystem.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildImageView(),
            const SizedBox(height: 12),
            _buildTextView(),
            const SizedBox(height: 20),
            _buildTimeLineButtons(),
            const SizedBox(height: 8),
            _buildNotificationTimeTextView(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageView() {
    if (state.drugImageUrl == null) {
      if (state.drugType == 'CUSTOM' || state.drugType == 'MEDICINE') {
        int idSum = state.drugId % 7;

        return Column(
          children: [
            const SizedBox(height: 46),
            SizedBox(
              width: 160,
              height: 70,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: const SvgImageView(
                      assetPath: "assets/icons/drug_background.svg",
                      width: 160,
                    ),
                  ),
                  Positioned(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 8),
                        SvgImageView(
                          assetPath: 'assets/icons/medicine_$idSum.svg',
                          width: 64,
                        ),
                        const Spacer(),
                        SvgImageView(
                          assetPath: 'assets/icons/medicine_$idSum.svg',
                          width: 64,
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 46),
          ],
        );
      }

      int idSum = state.drugId % 2;

      return Container(
        width: 160,
        height: 160,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          border: Border.all(
            color: ColorSystem.neutral.shade50,
            width: 1,
          ),
        ),
        child: SvgImageView(assetPath: 'assets/icons/vitamin_$idSum.svg'),
      );
    }

    if (state.drugType == 'CUSTOM') {
      throw Exception('Custom drug type must not have drug image url');
    }

    if (state.drugType == 'MEDICINE') {
      return Column(
        children: [
          const SizedBox(height: 47),
          NetworkImageView(
            imageUrl: state.drugImageUrl!,
            width: 160,
            height: 68,
            borderRadius: BorderRadius.circular(8),
            backgroundColor: Colors.white,
          ),
          const SizedBox(height: 47),
        ],
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ColorSystem.neutral.shade300,
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: NetworkImageView(
          imageUrl: state.drugImageUrl!,
          width: 160,
          height: 160,
          borderRadius: BorderRadius.circular(16),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildTextView() {
    return SizedBox(
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            state.drugType == 'VITAMIN'
                ? state.drugName!
                : state.drugClassificationOrManufacturer ?? '미등록 약품',
            overflow: TextOverflow.ellipsis,
            style: FontSystem.H5,
          ),
          Text(
            state.drugType == 'VITAMIN'
                ? state.drugClassificationOrManufacturer ?? '미등록 약품'
                : state.drugName!,
            overflow: TextOverflow.ellipsis,
            style: FontSystem.Sub3.copyWith(
              color: ColorSystem.neutral.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeLineButtons() {
    return SizedBox(
      height: 36,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTimeLineButton(
            text: '아침',
            isSelected: state.isTakenInBreakfast,
            onTap: onTapBreakfast,
          ),
          const SizedBox(width: 8),
          _buildTimeLineButton(
            text: '점심',
            isSelected: state.isTakenInLunch,
            onTap: onTapLunch,
          ),
          const SizedBox(width: 8),
          _buildTimeLineButton(
            text: '저녁',
            isSelected: state.isTakenInDinner,
            onTap: onTapDinner,
          ),
          const SizedBox(width: 8),
          _buildTimeLineButton(
            text: '기타',
            isSelected: state.isTakenInDaily,
            onTap: onTapDaily,
          ),
        ],
      ),
    );
  }

  Widget _buildTimeLineButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return FilledButton(
      onPressed: onTap,
      style: FilledButton.styleFrom(
        // Padding
        padding: EdgeInsets.zero,

        // Size
        minimumSize: const Size(56, 36),
        fixedSize: const Size(56, 36),

        // Color
        backgroundColor: isSelected
            ? ColorSystem.secondary.shade50
            : ColorSystem.neutral.shade200,
        foregroundColor: ColorSystem.white,

        disabledBackgroundColor: ColorSystem.neutral.shade300,

        // Border
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(18),
          ),
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: FontSystem.Sub2.copyWith(
            color: isSelected
                ? ColorSystem.secondary
                : ColorSystem.neutral.shade700,
            height: 1.0,
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationTimeTextView() {
    if (state.isTakenInDaily) {
      return Text(
        '알림을 받지 않을 예정이예요',
        style: FontSystem.Sub3.copyWith(
          color: ColorSystem.neutral.shade700,
        ),
      );
    }

    final List<String> notificationTimes = [];
    if (state.isTakenInBreakfast) {
      notificationTimes.add('아침');
    }
    if (state.isTakenInLunch) {
      notificationTimes.add('점심');
    }
    if (state.isTakenInDinner) {
      notificationTimes.add('저녁');
    }

    return Text(
      '${notificationTimes.join(', ')}에 알림을 받을 예정이예요',
      style: FontSystem.Sub3.copyWith(
        color: ColorSystem.neutral.shade700,
      ),
    );
  }
}
