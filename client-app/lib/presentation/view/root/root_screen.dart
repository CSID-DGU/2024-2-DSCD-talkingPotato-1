import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/utility/log_util.dart';
import 'package:wooahan/presentation/view/board/board_screen.dart';
import 'package:wooahan/presentation/view/home/home_screen.dart';
import 'package:wooahan/presentation/view/medication_management/medication_management_screen.dart';
import 'package:wooahan/presentation/view/root/widget/custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:wooahan/presentation/view/root/widget/drug_floating_action_button/drug_floating_action_button.dart';
import 'package:wooahan/presentation/view_model/root/root_view_model.dart';

class RootScreen extends GetView<RootViewModel> {
  const RootScreen({super.key});

  RootViewModel get viewModel => controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          extendBody: false,
          resizeToAvoidBottomInset: true,
          backgroundColor: ColorSystem.white,
          body: SafeArea(
            top: false,
            bottom: true,
            child: Obx(
              () => IndexedStack(
                index: controller.selectedIndex,
                children: const [
                  HomeScreen(),
                  MedicationManagementScreen(),
                  BoardScreen(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: const CustomBottomNavigationBar(),
        ),
        Obx(
          () {
            if (viewModel.selectedIndex != 1) {
              return const SizedBox();
            }

            return Positioned(
              right: 20,
              bottom: 116,
              child: DrugFloatingActionButton(
                onPressed: () {
                  LogUtil.info('약 추가하기 버튼 클릭');
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
