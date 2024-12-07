import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/presentation/view_model/comment/adding/comment_adding_view_model.dart';
import 'package:wooahan/presentation/widget/common/text_input/custom_text_form_field.dart';

class CommentInputField extends BaseWidget<CommentAddingViewModel> {
  const CommentInputField({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Obx(
      () => CustomInputTextField(
        content: viewModel.content,
        enable:
            !viewModel.isLoading && !viewModel.speechToTextState.isListening,
        minLines: 5,
        maxLines: 5,
        maxLength: 100,
        placeholder: '댓글을 입력해주세요(10자 이상)',
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
