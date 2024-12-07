import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/presentation/view/drug/detail/widget/drug_detail_information/component/drug_categories_card_view.dart';
import 'package:wooahan/presentation/view/drug/detail/widget/drug_detail_information/component/drug_default_card_view.dart';
import 'package:wooahan/presentation/view/drug/detail/widget/drug_detail_information/component/drug_image_card_view.dart';
import 'package:wooahan/presentation/view_model/drug/detail/drug_detail_view_model.dart';

class DrugDetailInformationView extends BaseWidget<DrugDetailViewModel> {
  const DrugDetailInformationView({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Obx(
      () {
        if (viewModel.isLoading) {
          return _buildSkeletonView();
        }

        return _buildDefaultView();
      },
    );
  }

  Widget _buildSkeletonView() {
    List<Widget> children = [];

    if (viewModel.type == "VITAMIN") {
      children.addAll(
        [
          Shimmer.fromColors(
            baseColor: ColorSystem.neutral.shade100,
            highlightColor: ColorSystem.white,
            child: Container(
              width: Get.width - 40,
              height: 160,
              decoration: BoxDecoration(
                color: ColorSystem.neutral.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Shimmer.fromColors(
            baseColor: ColorSystem.neutral.shade100,
            highlightColor: ColorSystem.white,
            child: Container(
              width: Get.width - 40,
              height: 160,
              decoration: BoxDecoration(
                color: ColorSystem.neutral.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Shimmer.fromColors(
            baseColor: ColorSystem.neutral.shade100,
            highlightColor: ColorSystem.white,
            child: Container(
              width: Get.width - 40,
              height: 160,
              decoration: BoxDecoration(
                color: ColorSystem.neutral.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(height: 36),
        ],
      );
    }

    children.addAll(
      [
        Shimmer.fromColors(
          baseColor: ColorSystem.neutral.shade100,
          highlightColor: ColorSystem.white,
          child: Container(
            width: Get.width - 40,
            height: 200,
            decoration: BoxDecoration(
              color: ColorSystem.neutral.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Shimmer.fromColors(
          baseColor: ColorSystem.neutral.shade100,
          highlightColor: ColorSystem.white,
          child: Container(
            width: Get.width - 40,
            height: 200,
            decoration: BoxDecoration(
              color: ColorSystem.neutral.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Shimmer.fromColors(
          baseColor: ColorSystem.neutral.shade100,
          highlightColor: ColorSystem.white,
          child: Container(
            width: Get.width - 40,
            height: 200,
            decoration: BoxDecoration(
              color: ColorSystem.neutral.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ],
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  Widget _buildDefaultView() {
    List<Widget> children = [];

    if (viewModel.type == "VITAMIN") {
      children.addAll(
        [
          DrugCategoriesCardView(
            title: '주요 기능',
            content: viewModel.drugDetail.categories,
          ),
          const SizedBox(height: 16),
          DrugDefaultCardView(
            title: '유통 기한',
            content: viewModel.drugDetail.expirationDate,
          ),
          const SizedBox(height: 16),
          DrugDefaultCardView(
            title: '보관 방법',
            content: viewModel.drugDetail.storageMethod,
          ),
          const SizedBox(height: 24),
        ],
      );
    }

    children.addAll(
      [
        DrugImageCardView(
          mainTitle: '이 약은',
          subTitle: '이런 효과를 가져요',
          svgPath: 'assets/icons/drug_counseling.svg',
          content: viewModel.drugDetail.effect,
        ),
        const SizedBox(height: 16),
        DrugImageCardView(
          mainTitle: '이 약은',
          subTitle: '이렇게 복용하세요',
          svgPath: 'assets/icons/drug_medicine.svg',
          content: viewModel.drugDetail.dosage,
        ),
        const SizedBox(height: 16),
        DrugImageCardView(
          mainTitle: '약을 먹기 전,',
          subTitle: '이 점을 유의하세요',
          svgPath: 'assets/icons/drug_warning.svg',
          content: viewModel.drugDetail.precaution,
        )
      ],
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}
