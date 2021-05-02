import 'package:commerce/constants.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Text(
            "Complete profile",
            style: headingStyle,
          ),
          Text(
            "Complete your profile or continue \n with social media",
            textAlign: TextAlign.center,
          ),
          CompleteProfileForm(),
        ],
      ),
    );
  }
}

class CompleteProfileForm extends StatefulWidget {
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  String firstName, lastName, phoneNumber, addreess;
  final List<String> errors = [];
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [],
      ),
    );
  }
}
