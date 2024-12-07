import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/presentation/view_model/article/searching/article_searching_view_model.dart';
import 'package:wooahan/presentation/widget/common/text_input/custom_text_form_field.dart';

class ArticleSearchTermField extends BaseWidget<ArticleSearchingViewModel> {
  const ArticleSearchTermField({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Obx(
      () => CustomInputTextField(
        content: viewModel.searchTerm,
        enable: !viewModel.isLoading,
        minLines: 1,
        maxLines: 1,
        placeholder: '검색어를 입력해주세요',
        hasSuffixIcon: viewModel.searchTerm.isNotEmpty,
        textInputType: TextInputType.text,
        textInputAction: TextInputAction.search,
        onChangedCallBack: viewModel.updateSearchTerm,
        onClearCallBack: viewModel.updateSearchTerm,
        onSubmittedCallBack: viewModel.updateArticleSummaryList,
      ),
    );
  }
}
