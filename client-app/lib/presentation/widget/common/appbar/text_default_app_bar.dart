import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';

class TextDefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TextDefaultAppBar({
    super.key,
    required this.preferredSize,
    required this.title,
    this.actions = const <Widget>[],
  });

  @override
  final Size preferredSize;

  final String title;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 4, right: 16),
      decoration: BoxDecoration(
        color: ColorSystem.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),
      child: AppBar(
        title: Text(
          title,
          style: FontSystem.H2,
        ),
        surfaceTintColor: ColorSystem.white,
        backgroundColor: ColorSystem.white,
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        centerTitle: false,
        actions: actions,
      ),
    );
  }
}
