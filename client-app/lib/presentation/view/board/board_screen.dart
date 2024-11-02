import 'package:flutter/material.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_screen.dart';
import 'package:wooahan/presentation/view/board/widget/board_card/board_card_list_view.dart';
import 'package:wooahan/presentation/view/board/widget/dialogue_card/question_card_list_view.dart';
import 'package:wooahan/presentation/view_model/board/board_view_model.dart';
import 'package:wooahan/presentation/widget/appbar/text_default_app_bar.dart';

class BoardScreen extends BaseScreen<BoardViewModel> {
  const BoardScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return const TextDefaultAppBar(
      preferredSize: Size.fromHeight(64),
      title: '게시판',
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 32),
            Text(
              '지금 많이 읽는 글',
              style: FontSystem.H4,
            ),
            SizedBox(height: 16),
            BoardCardListView(),
            SizedBox(height: 32),
            Text(
              '최근 올리온 질문',
              style: FontSystem.H4,
            ),
            SizedBox(height: 16),
            QuestionCardListView(),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
