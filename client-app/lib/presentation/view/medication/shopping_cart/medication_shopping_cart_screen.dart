import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_screen.dart';
import 'package:wooahan/presentation/view_model/medication/shopping_cart/medication_shopping_cart_view_model.dart';
import 'package:wooahan/presentation/widget/common/appbar/text_back_app_bar.dart';
import 'package:wooahan/presentation/widget/drug/summary/drug_summary_default_item_view.dart';

class MedicationShoppingCartScreen
    extends BaseScreen<MedicationShoppingCartViewModel> {
  const MedicationShoppingCartScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return TextBackAppBar(
      preferredSize: const Size.fromHeight(64),
      title: '추가할 약 목록',
      onBackPress: Get.back,
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  _buildDescriptionView(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ];
        },
        body: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: viewModel.drugSummaryList.length,
          itemBuilder: (context, index) {
            return DrugSummaryDefaultItemView(
              state: viewModel.drugSummaryList[index],
            );
          },
        ),
      ),
    );
  }

  Widget _buildDescriptionView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '추가할 약들이예요',
          style: FontSystem.H2,
        ),
        const SizedBox(height: 8),
        Text(
          '삭제는 복약 시간대를 설정할 때 가능해요.',
          style: FontSystem.Sub2.copyWith(
            color: ColorSystem.neutral.shade700,
          ),
        ),
      ],
    );
  }
}
