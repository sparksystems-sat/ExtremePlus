import 'package:exam_practice_app/l10n/language_constants.dart';
import 'package:exam_practice_app/screen/account/create_account.dart';
import 'package:exam_practice_app/widgets/body_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}
class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList.separated(
            itemCount: 5,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CreateUserPage(),
                    ),
                  );
                },
                horizontalTitleGap: 12,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                dense: true,
                leading: Icon(FontAwesomeIcons.circleUser, color: Colors.blue),
                title: body_text_page(
                  text_value:
                      "${t(context).bottom_profile}  $index",
                ),
                subtitle: body_text_page(
                  text_value: "This is a subtitle for item $index",
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
          ),
        ],
      ),
    );
  }
}
