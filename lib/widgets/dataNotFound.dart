import 'package:exam_practice_app/widgets/body_text.dart';
import 'package:exam_practice_app/widgets/medium_text.dart';
import 'package:flutter/material.dart';

class DataNotFound extends StatelessWidget {
  const DataNotFound({super.key, this.subTitle, this.imagePath, this.title});

  final String? title;
  final String? subTitle;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Container(
          width: MediaQuery.of(context).size.width * .99,
          height: MediaQuery.of(context).size.height * .35,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath ?? "resource/images/no_search.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        medium_text_page(textValue: title ?? "Oh no! We did not find"),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 28),
          child: body_text_page(
            text_value: subTitle ?? "Try another search term.",
          ),
        ),
        const SizedBox(height: 10),

        // Container(
        //   height: 50,
        //   width: MediaQuery.of(context).size.width *.8,
        //   decoration: BoxDecoration(
        //     color: AppColors.kPrimaryColor,
        //     border: Border.all(color: AppColors.borderColor),
        //     borderRadius: const BorderRadius.all(Radius.circular(10)),
        //   ),
        //   child: const Center(child: Text("Search Again")),
        // )
      ],
    );
  }
}
