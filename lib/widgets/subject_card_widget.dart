import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SubjectCardWidget extends StatelessWidget {
  final String subjectName;
  final String? svgAssetPath;
  final VoidCallback onTap;

  const SubjectCardWidget({
    super.key,
    required this.subjectName,
    this.svgAssetPath,
    required this.onTap,
  });

  static const double cardWidth = 165;
  static const double cardHeight = 100;
  static const double cardAspectRatio = cardWidth / cardHeight;

  String _getSubjectSvgAsset(String subjectName) {
    final normalized = subjectName.trim().toLowerCase().replaceAll(' ', '');
    return 'assets/svgs/subjects/$normalized.svg';
  }

  @override
  Widget build(BuildContext context) {
    final assetPath = svgAssetPath ?? _getSubjectSvgAsset(subjectName);

    return GestureDetector(
      onTap: onTap,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final scale = (constraints.maxWidth / cardWidth).clamp(0.0, 1.0);
          final scaledCardWidth = cardWidth * scale;
          final scaledCardHeight = cardHeight * scale;
          final iconSize = 32 * scale;
          final fontSize = 16 * scale;

          return Center(
            child: Container(
              width: scaledCardWidth,
              height: scaledCardHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24 * scale),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.10),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 14 * scale,
                vertical: 12 * scale,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    assetPath,
                    height: iconSize,
                    width: iconSize,
                  ),
                  SizedBox(height: 10 * scale),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      subjectName,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
