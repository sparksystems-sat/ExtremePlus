import 'package:exam_practice_app/utility/appColors.dart';
import 'package:exam_practice_app/widgets/dataNotFound.dart';
import 'package:exam_practice_app/widgets/iconWidget.dart';
import 'package:exam_practice_app/widgets/medium_text.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({super.key});
  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator> {
  late Future<void> _countDownFuture;
  bool _showIndicator = true;

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  void _startDelay() {
    _countDownFuture = Future.delayed(const Duration(seconds: 60), () {
      if (mounted) {
        setState(() {
          _showIndicator = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: null,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = <Widget>[const DataNotFound()];
        } else if (snapshot.hasError) {
          children = <Widget>[
            IconWidget(icon: Icons.error_outline, color: Colors.red, size: 60),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: medium_text_page(textValue: 'Error: ${snapshot.error}'),
            ),
          ];
        } else {
          children = <Widget>[
            LoadingAnimationWidget.discreteCircle(
              color: AppColors.primaryColor,
              size: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: medium_text_page(textValue: "Please wait..."),
            ),
          ];
        }
        return Center(
          child:
              _showIndicator
                  ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: children,
                  )
                  : const Text(""),
        );
      },
    );
  }
}
