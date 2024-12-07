import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/presentation/view_model/drug/detail/drug_detail_view_model.dart';
import 'package:wooahan/presentation/widget/common/image/network_image_view.dart';
import 'package:wooahan/presentation/widget/common/image/svg_image_view.dart';

class DrugBriefInformationView extends BaseWidget<DrugDetailViewModel> {
  const DrugBriefInformationView({super.key});

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
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: ColorSystem.neutral.shade100,
          highlightColor: ColorSystem.white,
          child: Container(
            width: Get.width - 40,
            height: viewModel.type == "VITAMIN" ? Get.width - 40 : 200,
            decoration: BoxDecoration(
              color: ColorSystem.neutral.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Shimmer.fromColors(
          baseColor: ColorSystem.neutral.shade100,
          highlightColor: ColorSystem.white,
          child: Container(
            width: Get.width / 2,
            height: 28,
            decoration: BoxDecoration(
              color: ColorSystem.neutral.shade100,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Shimmer.fromColors(
          baseColor: ColorSystem.neutral.shade100,
          highlightColor: ColorSystem.white,
          child: Container(
            width: Get.width - 180,
            height: 30,
            decoration: BoxDecoration(
              color: ColorSystem.neutral.shade100,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDefaultView() {
    Widget image;

    if (viewModel.drugSummary.imageUrl == null) {
      image = SizedBox(
        width: Get.width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: SvgImageView(
            assetPath: "assets/images/default_drug_image.svg",
            width: Get.width - 40,
            height: 200,
          ),
        ),
      );
    } else {
      image = NetworkImageView(
        imageUrl: viewModel.drugSummary.imageUrl!,
        width: Get.width - 40,
        height: viewModel.type == "VITAMIN" ? Get.width - 40 : 200,
        borderRadius: BorderRadius.circular(16),
        backgroundColor: Colors.white,
      );
    }

    return Column(
      children: [
        image,
        const SizedBox(height: 24),
        Text(
          viewModel.drugSummary.classificationOrManufacturer,
          style: FontSystem.H6.copyWith(
            color: ColorSystem.neutral.shade500,
          ),
        ),
        Text(
          viewModel.drugSummary.name,
          style: FontSystem.H3.copyWith(
            color: ColorSystem.neutral.shade900,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
