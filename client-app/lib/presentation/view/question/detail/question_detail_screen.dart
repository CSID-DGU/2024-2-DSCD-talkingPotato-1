import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/core/screen/base_screen.dart';
import 'package:wooahan/presentation/view/question/detail/widget/answer_card/answer_card_list_view.dart';
import 'package:wooahan/presentation/view/question/detail/widget/question_detail/question_detail_view.dart';
import 'package:wooahan/presentation/view_model/question/detail/question_detail_view_model.dart';
import 'package:wooahan/presentation/widget/common/appbar/text_back_app_bar.dart';

class QuestionDetailScreen extends BaseScreen<QuestionDetailViewModel> {
  const QuestionDetailScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return TextBackAppBar(
      preferredSize: const Size.fromHeight(64),
      title: '질문 상세',
      onBackPress: Get.back,
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const QuestionDetailView(),
            const AnswerCardListView(),
            SizedBox(height: GetPlatform.isAndroid ? 80 : 120),
          ],
        ),
      ),
    );
  }
}
