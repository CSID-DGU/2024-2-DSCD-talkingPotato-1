import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/presentation/view_model/question/adding/question_adding_view_model.dart';
import 'package:wooahan/presentation/widget/common/text_input/custom_text_form_field.dart';

class QuestionInputField extends BaseWidget<QuestionAddingViewModel> {
  const QuestionInputField({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Obx(
      () => CustomInputTextField(
        content: viewModel.content,
        enable:
            !viewModel.isLoading && !viewModel.speechToTextState.isListening,
        minLines: 8,
        maxLines: 8,
        maxLength: 500,
        placeholder: '질문를 입력해주세요(10자 이상)',
        enabledCounter: true,
        hasSuffixIcon: false,
        textInputType: TextInputType.multiline,
        textInputAction: TextInputAction.done,
        onChangedCallBack: viewModel.updateContent,
        onClearCallBack: viewModel.updateContent,
        onSubmittedCallBack: () {
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }
}
