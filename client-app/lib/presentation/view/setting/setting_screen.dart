import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/app_routes.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/core/screen/base_screen.dart';
import 'package:wooahan/presentation/view/setting/bottom_sheet/time_picker_bottom_sheet.dart';
import 'package:wooahan/presentation/view/setting/widget/text_section/text_section_view.dart';
import 'package:wooahan/presentation/view/setting/widget/time_section/time_section_view.dart';
import 'package:wooahan/presentation/view/setting/widget/toggle_section/toggle_section_view.dart';
import 'package:wooahan/presentation/view_model/setting/setting_view_model.dart';
import 'package:wooahan/presentation/widget/common/appbar/text_back_app_bar.dart';
import 'package:wooahan/presentation/widget/common/dialog/confirm_dialog.dart';
import 'package:wooahan/presentation/widget/common/line/infinity_horizon_line.dart';

class SettingScreen extends BaseScreen<SettingViewModel> {
  const SettingScreen({super.key});

  @override
  Color? get unSafeAreaColor => ColorSystem.white;

  @override
  Color? get screenBackgroundColor => ColorSystem.neutral.shade200;

  @override
  bool get wrapWithOuterSafeArea => true;

  @override
  bool get setTopOuterSafeArea => true;

  @override
  bool get setBottomOuterSafeArea => false;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return TextBackAppBar(
      preferredSize: const Size.fromHeight(64),
      title: '설정',
      onBackPress: Get.back,
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Container(
          color: ColorSystem.white,
          child: Column(
            children: [
              Obx(
                () => ToggleSectionView(
                  title: "알림 동의",
                  content: "복약할 시간에 알림을 받을 수 있어요.",
                  isActive: viewModel.isAllowedNotification,
                  onChanged: (value) {
                    viewModel.updateAllowedNotification().then((result) {
                      if (!result.success) {
                        Get.snackbar(
                          '알림 설정 실패',
                          result.message!,
                        );
                      }
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: InfinityHorizonLine(
                  gap: 0.5,
                  color: ColorSystem.neutral.shade300,
                ),
              ),
              Obx(
                () => TimeSectionView(
                  title: "아침",
                  hour: viewModel.breakfastTime.hour,
                  minute: viewModel.breakfastTime.minute,
                  onTap: () {
                    Get.bottomSheet(
                      TimePickerBottomSheet(
                        hour: viewModel.breakfastTime.hour,
                        minute: viewModel.breakfastTime.minute,
                        startedHour: 5,
                        endedHour: 9,
                        onCompleted: (hour, minute) {
                          viewModel
                              .updateNotificationTime('BREAKFAST', hour, minute)
                              .then((result) {
                            if (!result.success) {
                              Get.snackbar(
                                '알림 시간 변경 실패',
                                result.message!,
                                snackPosition: SnackPosition.TOP,
                              );
                            } else {
                              Get.back();
                            }
                          });
                        },
                      ),
                      isScrollControlled: true,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: InfinityHorizonLine(
                  gap: 0.5,
                  color: ColorSystem.neutral.shade300,
                ),
              ),
              Obx(
                () => TimeSectionView(
                  title: "점심",
                  hour: viewModel.lunchTime.hour,
                  minute: viewModel.lunchTime.minute,
                  onTap: () {
                    Get.bottomSheet(
                      TimePickerBottomSheet(
                        hour: viewModel.lunchTime.hour,
                        minute: viewModel.lunchTime.minute,
                        startedHour: 10,
                        endedHour: 14,
                        onCompleted: (hour, minute) {
                          viewModel
                              .updateNotificationTime('LUNCH', hour, minute)
                              .then((result) {
                            if (!result.success) {
                              Get.snackbar(
                                '알림 시간 변경 실패',
                                result.message!,
                                snackPosition: SnackPosition.TOP,
                              );
                            } else {
                              Get.back();
                            }
                          });
                        },
                      ),
                      isScrollControlled: true,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: InfinityHorizonLine(
                  gap: 0.5,
                  color: ColorSystem.neutral.shade300,
                ),
              ),
              Obx(
                () => TimeSectionView(
                  title: "저녁",
                  hour: viewModel.dinnerTime.hour,
                  minute: viewModel.dinnerTime.minute,
                  onTap: () {
                    Get.bottomSheet(
                      TimePickerBottomSheet(
                        hour: viewModel.dinnerTime.hour,
                        minute: viewModel.dinnerTime.minute,
                        startedHour: 15,
                        endedHour: 19,
                        onCompleted: (hour, minute) {
                          viewModel
                              .updateNotificationTime('DINNER', hour, minute)
                              .then((result) {
                            if (!result.success) {
                              Get.snackbar(
                                '알림 시간 변경 실패',
                                result.message!,
                                snackPosition: SnackPosition.TOP,
                              );
                            } else {
                              Get.back();
                            }
                          });
                        },
                      ),
                      isScrollControlled: true,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          color: ColorSystem.white,
          child: Column(
            children: [
              TextSectionView(
                title: '비밀번호 변경',
                textColor: ColorSystem.black.withOpacity(0.8),
                onTap: () {
                  Get.toNamed(AppRoutes.SETTING+AppRoutes.CHANGE_PASSWORD);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: InfinityHorizonLine(
                  gap: 0.5,
                  color: ColorSystem.neutral.shade300,
                ),
              ),
              TextSectionView(
                title: '로그아웃',
                textColor: ColorSystem.blue.shade400,
                onTap: () {
                  Get.dialog(
                    ConfirmDialog(
                      title: "로그아웃",
                      content: '로그아웃하시겠어요?',
                      onPressedCancel: Get.back,
                      onPressedApply: () {
                        viewModel.logout().then(
                          (value) {
                            if (value.success) {
                              Get.offAllNamed(AppRoutes.LOGIN);
                            } else {
                              Get.snackbar(
                                '로그아웃 실패',
                                value.message!,
                              );
                            }
                          },
                        );
                      },
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: InfinityHorizonLine(
                  gap: 0.5,
                  color: ColorSystem.neutral.shade300,
                ),
              ),
              TextSectionView(
                title: '회원탈퇴',
                textColor: ColorSystem.red.shade400,
                onTap: () {
                  Get.dialog(
                    ConfirmDialog(
                      title: "회원탈퇴",
                      content: '정말로 회원탈퇴하시겠어요?',
                      onPressedCancel: Get.back,
                      onPressedApply: () {
                        viewModel.withdrawal().then(
                          (value) {
                            if (value.success) {
                              Get.offAllNamed(AppRoutes.LOGIN);
                            } else {
                              Get.snackbar(
                                '회원탈퇴 실패',
                                value.message!,
                              );
                            }
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        SizedBox(height: GetPlatform.isAndroid ? 20 : 40),
      ],
    );
  }
}
