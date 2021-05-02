import 'package:commerce/components/custom_suffix_icon.dart';
import 'package:commerce/components/default_button.dart';
import 'package:commerce/components/form_error.dart';
import 'package:commerce/screens/complete_profile/complete_profile_screen.dart';
import 'package:flutter/material.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  String email, password, confirm_password;
  final List<String> errors = [];
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(
            height: 30,
          ),
          buildPasswordFormField(),
          SizedBox(
            height: 30,
          ),
          buildConfirmPasswordFormField(),
          FormError(
            errors: errors,
          ),
          SizedBox(
            height: 40,
          ),
          DefaultButton(
            text: "Signup",
            press: () {
              if (_formKey.currentState.validate()) {
                print("I am valid");
                Navigator.pushNamed(context, CompleteProfileScreen.routeName);
              }
            },
          )
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      onSaved: (newValue) => password = newValue,
      validator: (value) {
        if (value.isEmpty) {
          if (!errors.contains("Please enter your password")) {
            setState(() {
              errors.add("Please enter your password");
            });
          }
        } else {
          if (errors.contains("Please enter your password")) {
            setState(() {
              errors.remove("Please enter your password");
            });
          }
        }
        return null;
      },
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/Lock.svg",
        ),
      ),
    );
  }

  TextFormField buildConfirmPasswordFormField() {
    return TextFormField(
      onSaved: (newValue) => confirm_password = newValue,
      validator: (value) {
        if (value.isEmpty) {
          if (!errors.contains("Please enter confirm password")) {
            setState(() {
              errors.add("Please enter confirm password");
            });
          }
        } else {
          if (errors.contains("Please enter confirm password")) {
            setState(() {
              errors.remove("Please enter confirm password");
            });
          }
        }
        return null;
      },
      obscureText: true,
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Enter confirm password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/Lock.svg",
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      onSaved: (newValue) => email = newValue,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value.isEmpty) {
          if (!errors.contains("Please enter your email")) {
            setState(() {
              errors.add("Please enter your email");
            });
          }
        } else {
          if (errors.contains("Please enter your email")) {
            setState(() {
              errors.remove("Please enter your email");
            });
          }
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(
          svgIcon: "assets/icons/Mail.svg",
        ),
      ),
    );
  }
}
