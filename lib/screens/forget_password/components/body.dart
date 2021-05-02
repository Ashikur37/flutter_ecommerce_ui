import 'package:commerce/components/No_account_text.dart';
import 'package:commerce/components/custom_suffix_icon.dart';
import 'package:commerce/components/default_button.dart';
import 'package:commerce/components/form_error.dart';
import 'package:commerce/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.screenHeight * 0.04,
              ),
              Text(
                "Forgot password",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(28),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Please enter your email and we will send \n you a link to return to your account",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: getProportionateScreenHeight(30),
              ),
              ForgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  String email, password;
  final List<String> errors = [];
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
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
          ),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          FormError(
            errors: errors,
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.1,
          ),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
              }
            },
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.1,
          ),
          NoAccountText(),
        ],
      ),
    );
  }
}
