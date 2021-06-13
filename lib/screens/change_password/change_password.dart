import 'package:commerce/components/custom_surfix_icon.dart';
import 'package:commerce/components/default_button.dart';
import 'package:commerce/components/form_error.dart';
import 'package:commerce/helper/http.dart';
import 'package:commerce/size_config.dart';
import 'package:commerce/utilities/const.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class ChangePassword extends StatefulWidget {
  static String routeName = '/change-password';
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  String password;
  String oldPassword;

  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change password'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(30)),
              buildOldPasswordFormField(),
              SizedBox(height: getProportionateScreenHeight(30)),
              buildPasswordFormField(),
              SizedBox(height: getProportionateScreenHeight(30)),
              FormError(errors: errors),
              SizedBox(height: getProportionateScreenHeight(20)),
              DefaultButton(
                text: "Continue",
                press: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    // if all are valid then go to success screen
                    //signin
                    var data = await postHttp(
                        "$baseUrl$loginUrl", {"password": password});
                    print(data);
                    if (data["success"]) {
                    } else {}
                    // KeyboardUtil.hideKeyboard(context);
                    // Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "New Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildOldPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => oldPassword = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Old Password",
        hintText: "Enter old password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }
}
