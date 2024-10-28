import 'package:flutter/material.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_screen.dart';
import 'package:wooahan/presentation/view_model/board/board_view_model.dart';

class BoardScreen extends BaseScreen<BoardViewModel> {
  const BoardScreen({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return const Center(
      child: Text(
        'Board Screen',
        style: FontSystem.Sub2,
      ),
    );
  }
}
