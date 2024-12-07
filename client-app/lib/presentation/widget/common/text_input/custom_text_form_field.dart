import 'package:flutter/material.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';

class CustomInputTextField extends StatefulWidget {
  const CustomInputTextField({
    super.key,
    this.content = '',
    this.textStyle = FontSystem.Sub2,
    this.maxLength,
    this.maxLines = 1,
    this.minLines = 1,
    this.enabledCounter = false,
    this.label,
    this.placeholder,
    this.validator,
    this.focusNode,
    this.hasSuffixIcon = true,
    this.obscureText = false,
    this.enableSuggestions = false,
    this.autocorrect = false,
    this.textInputType = TextInputType.none,
    required this.enable,
    this.fillColor,
    this.textInputAction = TextInputAction.done,
    required this.onChangedCallBack,
    required this.onClearCallBack,
    required this.onSubmittedCallBack,
  });

  final String content;
  final TextStyle textStyle;
  final int? maxLength;
  final int maxLines;
  final int minLines;
  final bool enabledCounter;
  final String? label;
  final String? placeholder;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final bool hasSuffixIcon;
  final bool obscureText;
  final bool enableSuggestions;
  final bool autocorrect;
  final TextInputType textInputType;
  final bool enable;
  final Color? fillColor;
  final TextInputAction textInputAction;
  final Function() onSubmittedCallBack;
  final Function(String) onClearCallBack;
  final Function(String) onChangedCallBack;

  @override
  State<CustomInputTextField> createState() => _CustomInputTextFieldState();
}

class _CustomInputTextFieldState extends State<CustomInputTextField> {
  late final TextEditingController controller;

  late bool enable;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();

    enable = widget.enable;
  }

  @override
  void didUpdateWidget(covariant CustomInputTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.enable != widget.enable) {
      setState(() {
        enable = widget.enable;
      });
    }

    if (oldWidget.content != widget.content) {
      controller.text = widget.content;
    }
  }

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      focusNode: widget.focusNode,
      keyboardType: widget.textInputType,
      textInputAction: widget.textInputAction,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      cursorColor: ColorSystem.primary.shade500,
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.left,
      obscureText: widget.obscureText,
      enableSuggestions: widget.enableSuggestions,
      autocorrect: widget.autocorrect,
      style: widget.textStyle,
      enabled: enable,
      maxLength: widget.maxLength,
      onChanged: (value) {
        setState(() {
          controller.text = value;
        });

        widget.onChangedCallBack(value);
      },
      onFieldSubmitted: (_) {
        widget.onSubmittedCallBack();
        widget.focusNode?.unfocus();
      },
      decoration: InputDecoration(
        filled: widget.fillColor != null,
        fillColor: widget.fillColor,
        labelText: widget.label,
        labelStyle: widget.textStyle.copyWith(
          color: ColorSystem.neutral.shade700,
        ),
        hintText: widget.placeholder,
        hintStyle: widget.textStyle.copyWith(
          color: ColorSystem.neutral.shade500,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 17,
        ),
        errorStyle: FontSystem.Sub3.copyWith(
          color: ColorSystem.red.shade600,
          height: 1,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: ColorSystem.neutral.shade300,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: ColorSystem.primary.shade500,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: ColorSystem.red.shade600,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: ColorSystem.red.shade600,
            width: 2,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: ColorSystem.neutral.shade200,
            width: 1,
          ),
        ),
        counterText: widget.enabledCounter
            ? '${controller.text.length}/${widget.maxLength}'
            : null,
        suffixIcon: widget.hasSuffixIcon
            ? Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 10, 10),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      controller.clear();
                    });
                    widget.onClearCallBack('');
                  },
                  behavior: HitTestBehavior.translucent,
                  child: ValueListenableBuilder(
                    valueListenable: controller,
                    builder: (_, __, ___) {
                      return Icon(
                        Icons.clear,
                        color: ColorSystem.neutral,
                        size: 20,
                      );
                    },
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
