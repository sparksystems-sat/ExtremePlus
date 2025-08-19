import 'package:exam_practice_app/l10n/language_constants.dart';
import 'package:exam_practice_app/utility/appColors.dart';
import 'package:exam_practice_app/utility/student_grade.dart';
import 'package:exam_practice_app/widgets/big_text.dart';
import 'package:exam_practice_app/widgets/body_text.dart';
import 'package:exam_practice_app/widgets/medium_text.dart';
import 'package:exam_practice_app/widgets/text_filed_form.dart';
import 'package:flutter/material.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({super.key});

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  String? _selectedGrade;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Create User'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  big_text_page(text_value: t(context).create_account),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            InputTextFormField(
              obscureText: false,
              labelText: t(context).first_name,
              controller: TextEditingController(),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a username';
                }
                return null;
              },
              hintTxt: t(context).first_name,
            ),
            InputTextFormField(
              obscureText: false,
              labelText: t(context).father_name,
              controller: TextEditingController(),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a father name';
                }
                return null;
              },
              hintTxt: t(context).father_name,
            ),
            InputTextFormField(
              obscureText: false,
              labelText: t(context).grand_fname,
              controller: TextEditingController(),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a grand father name';
                }
                return null;
              },
              hintTxt: t(context).grand_fname,
            ),
            SizedBox(height: 16),
            InputTextFormField(
              obscureText: false,
              labelText: t(context).phone_number,
              controller: TextEditingController(),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a phone number';
                }
                return null;
              },
              hintTxt: '+25112345678',
            ),
            SizedBox(height: 16),
            InputTextFormField(
              obscureText: false,
              labelText: 'Email',
              controller: TextEditingController(),
              keyboardType: TextInputType.visiblePassword,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a email';
                }
                return null;
              },
              hintTxt: 'email',
            ),
            SizedBox(height: 16),
            InputTextFormField(
              obscureText: true,
              labelText: 'password',
              controller: TextEditingController(),
              keyboardType: TextInputType.visiblePassword,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a password';
                }
                return null;
              },
              hintTxt: 'Password',
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                value: _selectedGrade,

                decoration: InputDecoration(
                  fillColor: AppColors.main_background_color.withOpacity(0.2),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: "Select Grade",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: AppColors.text_color.withOpacity(0.1),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: AppColors.text_color.withOpacity(0.2),
                    ),
                  ),
                ),
                hint: Text('Select a Grade'),
                items:
                    StudentStream.studentGrade.map((String fruit) {
                      return DropdownMenuItem<String>(
                        value: fruit,
                        child: Text(fruit),
                      );
                    }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedGrade = newValue;
                  });
                },
              ),
            ),

            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 100.0,
                ),
                textStyle: TextStyle(
                  fontSize: 16.0,
                  color: AppColors.main_background_color,
                ),

                backgroundColor: AppColors.button3Color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                // Handle user creation logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('User Created Successfully')),
                );
              },
              child: Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w900,
                  color: AppColors.main_background_color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
