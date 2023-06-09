// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RotatePokeballWidget extends StatefulWidget {
  const RotatePokeballWidget({
    super.key,
    this.color,
    this.milliseconds = 1000,
    this.size = 100,
  });
  final double size;
  final Color? color;
  final int milliseconds;

  @override
  State<RotatePokeballWidget> createState() => _RotatePokeballWidgetState();
}

class _RotatePokeballWidgetState extends State<RotatePokeballWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.milliseconds),
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: SvgPicture.asset(
          'assets/icons/pokeball_loading.svg',
          color: widget.color ?? Colors.white.withOpacity(0.30),
        ),
      ),
    );
  }
}
