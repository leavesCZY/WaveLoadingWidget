import 'dart:math';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class WaveLoading extends StatefulWidget {
  final String text;

  final double fontSize;

  final Color backgroundColor;

  final Color foregroundColor;

  final Color waveColor;

  WaveLoading({
    Key? key,
    required this.text,
    required this.fontSize,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.waveColor,
  }) : super(key: key) {
    assert(text.isNotEmpty && fontSize > 0);
  }

  @override
  State<StatefulWidget> createState() {
    return _WaveLoadingState();
  }
}

class _WaveLoadingState extends State<WaveLoading>
    with SingleTickerProviderStateMixin {
  String get _text => widget.text;

  double get _fontSize => widget.fontSize;

  Color get _backgroundColor => widget.backgroundColor;

  Color get _foregroundColor => widget.foregroundColor;

  Color get _waveColor => widget.waveColor;

  late AnimationController _controller;

  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller)
      ..addListener(() {
        setState(() => {});
      });
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        painter: _WaveLoadingPainter(
          text: _text,
          fontSize: _fontSize,
          animatedValue: _animation.value,
          backgroundColor: _backgroundColor,
          foregroundColor: _foregroundColor,
          waveColor: _waveColor,
        ),
      ),
    );
  }
}

class _WaveLoadingPainter extends CustomPainter {
  final String text;

  final double fontSize;

  final double animatedValue;

  final Color backgroundColor;

  final Color foregroundColor;

  final Color waveColor;

  _WaveLoadingPainter({
    required this.text,
    required this.fontSize,
    required this.animatedValue,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.waveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final side = min(size.width, size.height);
    _drawText(canvas: canvas, side: side, color: backgroundColor);
    final circlePath = Path();
    circlePath.addArc(Rect.fromLTWH(0, 0, side, side), 0, 2 * pi);
    final waveWidth = side * 0.8;
    final waveHeight = side / 6;
    final wavePath = Path();
    final radius = side / 2.0;
    wavePath.moveTo((animatedValue - 1) * waveWidth, radius);
    for (double i = -waveWidth; i < side; i += waveWidth) {
      wavePath.relativeQuadraticBezierTo(
          waveWidth / 4, -waveHeight, waveWidth / 2, 0);
      wavePath.relativeQuadraticBezierTo(
          waveWidth / 4, waveHeight, waveWidth / 2, 0);
    }
    wavePath.relativeLineTo(0, radius);
    wavePath.lineTo(-waveWidth, side);
    wavePath.close();
    final paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..strokeWidth = 3
      ..color = waveColor;
    final combinePath =
        Path.combine(PathOperation.intersect, circlePath, wavePath);
    canvas.drawPath(combinePath, paint);
    canvas.clipPath(combinePath);
    _drawText(canvas: canvas, side: side, color: foregroundColor);
  }

  void _drawText(
      {required Canvas canvas, required double side, required Color color}) {
    ParagraphBuilder paragraphBuilder = ParagraphBuilder(ParagraphStyle(
      textAlign: TextAlign.center,
      fontStyle: FontStyle.normal,
      fontSize: fontSize,
    ));
    paragraphBuilder.pushStyle(ui.TextStyle(color: color));
    paragraphBuilder.addText(text);
    ParagraphConstraints pc = ParagraphConstraints(width: fontSize);
    Paragraph paragraph = paragraphBuilder.build()..layout(pc);
    canvas.drawParagraph(
      paragraph,
      Offset((side - paragraph.width) / 2.0, (side - paragraph.height) / 2.0),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return animatedValue != (oldDelegate as _WaveLoadingPainter).animatedValue;
  }
}
