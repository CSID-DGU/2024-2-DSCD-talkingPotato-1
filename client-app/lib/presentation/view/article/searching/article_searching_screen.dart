import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/core/screen/base_screen.dart';
import 'package:wooahan/presentation/view/article/searching/widget/article_result/article_result_view.dart';
import 'package:wooahan/presentation/view/article/searching/widget/article_search_term_field/article_search_term_field.dart';
import 'package:wooahan/presentation/view_model/article/searching/article_searching_view_model.dart';
import 'package:wooahan/presentation/widget/common/appbar/text_back_app_bar.dart';

class ArticleSearchingScreen extends BaseScreen<ArticleSearchingViewModel> {
  const ArticleSearchingScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return TextBackAppBar(
      preferredSize: const Size.fromHeight(64),
      title: '정보 글 검색하기',
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
              const ArticleSearchTermField(),
              const SizedBox(height: 16),
              const ArticleResultView(),
              SizedBox(height: GetPlatform.isAndroid ? 20 : 40),
            ],
          ),
        ),
      ),
    );
  }
}
