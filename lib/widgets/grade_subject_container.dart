import 'package:exam_practice_app/utility/appColors.dart';
import 'package:exam_practice_app/widgets/body_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GradeSubjectContainer extends StatefulWidget {
  final String containerTitle;
  final IconData icon;
  const GradeSubjectContainer({
    super.key,
    required this.containerTitle,
    required this.icon,
  });
  @override
  State<GradeSubjectContainer> createState() => _GradeSubjectContainerState();
}

class _GradeSubjectContainerState extends State<GradeSubjectContainer> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      height: size.width * 0.3,
      width: size.width * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(width: 1, color: Colors.white),
        boxShadow: [
          
          BoxShadow(
            // blurRadius: 4,
            color: Colors.white ,//color of shadow
            // color: Color(), //edited
            spreadRadius: 1,
            blurRadius: 1,

            // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {},
              icon: FaIcon(
                widget.icon,
                size: size.width * 0.1,
                color: AppColors.icon_color,
              ),
            ),
            SizedBox(height: 8),
            body_text_page(text_value: widget.containerTitle),
          ],
        ),
      ),
    );
  }
}
