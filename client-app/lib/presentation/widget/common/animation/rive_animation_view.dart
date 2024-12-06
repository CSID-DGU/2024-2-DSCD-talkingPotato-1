import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveAnimationView extends StatefulWidget {
  const RiveAnimationView({
    super.key,
    required this.assetName,
    required this.artboardName,
    this.autoplay = true,
  });

  final String assetName;
  final String artboardName;
  final bool autoplay;

  @override
  State<RiveAnimationView> createState() => _RiveAnimationViewState();
}

class _RiveAnimationViewState extends State<RiveAnimationView> {
  late final SimpleAnimation _controller;

  @override
  void initState() {
    super.initState();

    _controller = SimpleAnimation(
      widget.artboardName,
      autoplay: widget.autoplay,
    );
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RiveAnimation.asset(
      widget.assetName,
      controllers: [
        _controller,
      ],
    );
  }
}
