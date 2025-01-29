import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class BlurContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final Widget? child;
  final double borderRadius;

  const BlurContainer({
    Key? key,
    this.height,
    this.child,
    this.width,
    this.borderRadius = 10.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: GradientBoxBorder(
          gradient: LinearGradient(
            begin: Alignment(1, -1), // Top-right corner
            end: Alignment(1, 1),   // Bottom-right corner
            colors: [
              Colors.white.withOpacity(0.4),
              Colors.white.withOpacity(0.1),
            ],
          ),
          width: 1,
        ),
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.03),
            Colors.white.withOpacity(0.05),
          ],
          stops: [0.2, 0.8],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.white.withOpacity(0.03),
            alignment: Alignment.center,
            child: child, // Render child directly
          ),
        ),
      ),
    );
  }
}
