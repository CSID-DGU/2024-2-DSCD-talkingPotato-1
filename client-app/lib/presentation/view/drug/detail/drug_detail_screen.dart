import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_screen.dart';
import 'package:wooahan/presentation/view/drug/detail/widget/drug_brief_information/drug_brief_information_view.dart';
import 'package:wooahan/presentation/view/drug/detail/widget/drug_detail_information/drug_detail_information_view.dart';
import 'package:wooahan/presentation/view_model/drug/detail/drug_detail_view_model.dart';
import 'package:wooahan/presentation/widget/common/appbar/text_back_app_bar.dart';

class DrugDetailScreen extends BaseScreen<DrugDetailViewModel> {
  const DrugDetailScreen({super.key});

  @override
  Color get unSafeAreaColor => ColorSystem.neutral.shade200;

  @override
  Color? get screenBackgroundColor => ColorSystem.neutral.shade200;

  @override
  bool get wrapWithOuterSafeArea => true;

  @override
  bool get setTopOuterSafeArea => true;

  @override
  bool get setBottomOuterSafeArea => false;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return TextBackAppBar(
      title: '약 상세 정보',
      backgroundColor: ColorSystem.neutral.shade200,
      onBackPress: Get.back,
      preferredSize: const Size.fromHeight(64),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 32),
            const DrugBriefInformationView(),
            const SizedBox(height: 32),
            const DrugDetailInformationView(),
            const SizedBox(height: 32),
            _buildSourceTextView(),
            GetPlatform.isAndroid
                ? const SizedBox(height: 20)
                : const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSourceTextView() {
    return SizedBox(
      width: Get.width - 40,
      child: Text(
        '약 정보는 식품의약품안전처 DB를 토대로 제공된 정보입니다.'
        '\n'
        '아래 링크 방문 시 확인 가능합니다.'
        '\n'
        '\n'
        '식품의약품안전처 DB : https://www.data.go.kr/data/15085712/openapi.do?recommendDataYn=Y',
        style: FontSystem.Sub3.copyWith(
          fontSize: 12,
          color: ColorSystem.neutral.shade500,
        ),
      ),
    );
  }
}
