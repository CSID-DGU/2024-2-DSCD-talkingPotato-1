import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/presentation/view_model/root/root_view_model.dart';
import 'package:wooahan/presentation/widget/common/image/svg_image_view.dart';

class CustomBottomNavigationBar extends BaseWidget<RootViewModel> {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ColorSystem.neutral.shade100,
              blurRadius: 8,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Obx(
          () => BottomNavigationBar(
            // State Management
            currentIndex: viewModel.selectedIndex,
            onTap: viewModel.updateIndex,

            // Design
            backgroundColor: ColorSystem.white,
            type: BottomNavigationBarType.fixed,

            // When not selected
            unselectedItemColor: ColorSystem.neutral.shade400,
            unselectedLabelStyle: FontSystem.Sub3.copyWith(
              fontSize: 12,
              height: 1.714,
            ),

            // When selected
            selectedItemColor: ColorSystem.primary,
            selectedLabelStyle: FontSystem.Sub3.copyWith(
              fontSize: 12,
              height: 1.714,
            ),

            // Items
            items: [
              BottomNavigationBarItem(
                icon: SvgImageView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  assetPath: 'assets/icons/home.svg',
                  height: 24,
                  color: viewModel.selectedIndex == 0
                      ? ColorSystem.primary
                      : ColorSystem.neutral.shade400,
                ),
                label: "홈",
              ),
              BottomNavigationBarItem(
                icon: SvgImageView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  assetPath: 'assets/icons/medication_management.svg',
                  height: 24,
                  color: viewModel.selectedIndex == 1
                      ? ColorSystem.primary
                      : ColorSystem.neutral.shade400,
                ),
                label: "복약 관리",
              ),
              BottomNavigationBarItem(
                icon: SvgImageView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  assetPath: 'assets/icons/chatting.svg',
                  height: 24,
                  color: viewModel.selectedIndex == 2
                      ? ColorSystem.primary
                      : ColorSystem.neutral.shade400,
                ),
                label: "게시판",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
