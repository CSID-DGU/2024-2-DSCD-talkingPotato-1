import 'package:flutter/material.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/presentation/view/home/widget/user_information/component/my_step_graph_layer.dart';
import 'package:wooahan/presentation/view/home/widget/user_information/component/user_name_layer.dart';
import 'package:wooahan/presentation/view_model/home/home_view_model.dart';

class UserInformationView extends BaseWidget<HomeViewModel> {
  const UserInformationView({super.key});

  @override
  Widget buildView(BuildContext context) {
    return const SizedBox(
      height: 368,
      child: Stack(
        children: [
          UserNameLayer(nickname: "김우아한"),
          Positioned(
            top: 74 + 20,
            left: 0,
            right: 0,
            child: MyStepGraphLayer(
              stepCount: 10000,
            ),
          ),
        ],
      ),
    );
  }
}
