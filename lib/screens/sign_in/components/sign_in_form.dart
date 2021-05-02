import 'package:commerce/components/custom_suffix_icon.dart';
import 'package:commerce/components/default_button.dart';
import 'package:commerce/components/form_error.dart';
import 'package:commerce/screens/forget_password/forget_password_screen.dart';
import 'package:commerce/screens/login_success/login_success_screen.dart';
import 'package:commerce/size_config.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class SigninForm extends StatefulWidget {
  @override
  _SigninFormState createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final _formKey = GlobalKey<FormState>();
  String email, password;
  final List<String> errors = [];
  bool remember = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          buildPasswordFormField(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text("Remember Me"),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ForgetPasswordScreen.routeName);
                },
                child: Text(
                  "Forgot password?",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          FormError(
            errors: errors,
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          DefaultButton(
            text: "Signin",
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                Navigator.pushNamed(context, LoginSuccessScreen.routeName);
              }
            },
          ),
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
