import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/app_routes.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/presentation/view/question/default/widget/question_summary_card_list_view.dart';
import 'package:wooahan/presentation/view_model/question/default/question_view_model.dart';
import 'package:wooahan/presentation/widget/common/appbar/text_back_app_bar.dart';
import 'package:wooahan/presentation/widget/common/button/primary/primary_fill_button.dart';

class QuestionScreen extends GetView<QuestionViewModel> {
  const QuestionScreen({super.key});

  QuestionViewModel get viewModel => controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildContentLayer(),
        _buildButtonLayer(),
      ],
    );
  }

  Widget _buildContentLayer() {
    return Scaffold(
      extendBody: false,
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorSystem.white,
      appBar: TextBackAppBar(
        preferredSize: const Size.fromHeight(64),
        title: '질문 목록',
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(AppRoutes.QUESTION + AppRoutes.SEARCHING_PATH);
            },
            icon: const Icon(
              Icons.search,
              size: 32,
              color: ColorSystem.black,
            ),
          ),
          const SizedBox(width: 8),
        ],
        onBackPress: Get.back,
      ),
      body: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: RefreshIndicator(
            onRefresh: viewModel.onRefresh,
            child: const QuestionSummaryCardListView(),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonLayer() {
    return Positioned(
      right: 20,
      bottom: GetPlatform.isAndroid ? 20 : 40,
      child: PrimaryFillButton(
        width: Get.width - 40,
        height: 60,
        content: '질문 작성하기',
        onPressed: () {
          Get.toNamed(
            AppRoutes.QUESTION + AppRoutes.ADDING_PATH,
          );
        },
      ),
    );
  }
}
