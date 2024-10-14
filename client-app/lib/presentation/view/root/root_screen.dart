import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/presentation/view_model/root/root_view_model.dart';
import 'package:wooahan/presentation/widget/appbar/text_default_app_bar.dart';
import 'package:wooahan/presentation/widget/image/network_image_view.dart';

class RootScreen extends GetView<RootViewModel> {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorSystem.white,
      appBar: TextDefaultAppBar(
        title: 'Root',
        preferredSize: Size.fromHeight(56),
      ),
      body: Center(
        child: NetworkImageView(
          imageUrl:
              'https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2F5wTUs%2Fbtr4s2sWMR8%2Fftrw7OaIyKxwpOkeJHqC9K%2Fimg.png',
          width: 200,
          height: 200,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }
}
