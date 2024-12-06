import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/presentation/view_model/medication/adding/medication_adding_view_model.dart';
import 'package:wooahan/presentation/widget/common/text_input/custom_text_form_field.dart';

class DrugSearchTermField extends BaseWidget<MedicationAddingViewModel> {
  const DrugSearchTermField({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Obx(
      () {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.linearToEaseOut,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: viewModel.isFocusedSearchTermField ||
                          viewModel.searchTerm.isNotEmpty
                      ? 0
                      : 1,
                  curve: Curves.easeInOut,
                  child: !viewModel.isFocusedSearchTermField &&
                          !viewModel.searchTerm.isNotEmpty
                      ? _buildTitleView()
                      : const SizedBox(),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: viewModel.isFocusedSearchTermField ||
                        viewModel.searchTerm.isNotEmpty
                    ? 0
                    : 32,
              ),
              CustomInputTextField(
                minLines: 1,
                maxLines: 1,
                placeholder: '검색어를 입력해주세요',
                enable: !viewModel.isLoadingSearching,
                focusNode: viewModel.focusNode,
                hasSuffixIcon: viewModel.searchTerm.isNotEmpty,
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.search,
                onChangedCallBack: viewModel.updateSearchTerm,
                onClearCallBack: viewModel.updateSearchTerm,
                onSubmittedCallBack: viewModel.updateDrugBriefList,
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildTitleView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "약 검색하기",
          style: FontSystem.H1.copyWith(
            color: ColorSystem.neutral.shade900,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '이름을 정확하게 입력해야해요!',
          style: FontSystem.Sub2.copyWith(
            color: ColorSystem.neutral.shade500,
          ),
        ),
      ],
    );
  }
}
