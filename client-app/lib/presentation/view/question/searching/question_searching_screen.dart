import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/core/screen/base_screen.dart';
import 'package:wooahan/presentation/view/question/searching/widget/question_result/question_result_view.dart';
import 'package:wooahan/presentation/view/question/searching/widget/question_search_term_field/question_search_term_field.dart';
import 'package:wooahan/presentation/view_model/question/searching/question_searching_view_model.dart';
import 'package:wooahan/presentation/widget/common/appbar/text_back_app_bar.dart';

class QuestionSearchingScreen extends BaseScreen<QuestionSearchingViewModel> {
  const QuestionSearchingScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return TextBackAppBar(
      preferredSize: const Size.fromHeight(64),
      title: '질문 검색하기',
      onBackPress: Get.back,
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: ColorSystem.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              const QuestionSearchTermField(),
              const SizedBox(height: 16),
              const QuestionResultView(),
              SizedBox(height: GetPlatform.isAndroid ? 20 : 40),
            ],
          ),
        ),
      ),
    );
  }
}
