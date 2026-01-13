import 'package:flutter/material.dart';

class CountdownProgressBar extends StatelessWidget {
  const CountdownProgressBar({
    super.key,
    required this.progress,
    required this.color,
  });

  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const barHeight = 6.0;
        const knobDiameter = 14.0;

        final p = progress.clamp(0.0, 1.0);
        final width = constraints.maxWidth;
        final filled = width * p;
        final knobLeft = (filled - knobDiameter / 2).clamp(
          0.0,
          (width - knobDiameter).clamp(0.0, double.infinity),
        );

        return SizedBox(
          height: knobDiameter,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                height: barHeight,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: barHeight,
                  width: filled,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              Positioned(
                left: knobLeft,
                child: Container(
                  width: knobDiameter,
                  height: knobDiameter,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
