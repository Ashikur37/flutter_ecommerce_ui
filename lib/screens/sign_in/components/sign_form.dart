import 'package:commerce/helper/auth.dart';
import 'package:commerce/helper/http.dart';
import 'package:commerce/screens/profile/profile_screen.dart';
import 'package:commerce/utilities/const.dart';
import 'package:flutter/material.dart';
import 'package:commerce/components/custom_surfix_icon.dart';
import 'package:commerce/components/form_error.dart';
import 'package:commerce/helper/keyboard.dart';
import 'package:commerce/screens/forgot_password/forgot_password_screen.dart';
import 'package:commerce/screens/login_success/login_success_screen.dart';

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  final Function showMessage;

  const SignForm({Key key, this.showMessage}) : super(key: key);
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  String email;
  String password;
  bool remember = false;
  bool hide = true;
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
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildPhoneFormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(3)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                // color: Colors.red,
                width: 20,
                margin: EdgeInsets.only(right: 6),
                child: Checkbox(
                  value: remember,
                  activeColor: kPrimaryColor,
                  onChanged: (value) {
                    setState(() {
                      remember = value;
                    });
                  },
                ),
              ),
              Text(
                "Remember me",
                style: TextStyle(
                  // decoration: TextDecoration.underline,
                  fontSize: 16,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    // decoration: TextDecoration.underline,
                    fontSize: 15,
                  ),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(22)),
          DefaultButton(
            text: "Continue",
            press: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                // if all are valid then go to success screen
                //signin
                var data = await postHttp("$baseUrl$loginUrl",
                    {"email": email, "password": password});
                if (data["success"]) {
                  await localLogin(data["user"], data["token"]);
                  widget.showMessage("Signin success", Colors.greenAccent);
                  Navigator.popAndPushNamed(context, ProfileScreen.routeName);
                } else {
                  widget.showMessage("Signin failed", Colors.redAccent);
                }
                // KeyboardUtil.hideKeyboard(context);
                // Navigator.pushNamed(context, LoginSuccessScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: hidePassword,
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
        }
        return null;
      },
      decoration: InputDecoration(
        fillColor: Color(0XFFf5f5f5),
        // fillColor: Colors.blue.shade100.withOpacity(.09),
        filled: true,
        contentPadding: EdgeInsets.only(top: 27),
        // isDense: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Color(0XFFFf6f6f6), width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Color(0XFFFf6f6f6),
            width: 1.0,
          ),
        ),

        // labelText: "Passwordddd",
        hintText: "Enter password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIconConstraints: BoxConstraints(
          minWidth: 40,
        ),
        prefixIcon: GestureDetector(
          onTap: () {
            setState(() {
              hide = !hide;
            });
          },
          child: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
        ),

        suffixIcon: IconButton(
          icon: Icon(
            hidePassword ? Icons.visibility_off : Icons.visibility,
            size: 22,
            color: Color(0XFF464646),
          ),
          onPressed: () {
            setState(() {
              hidePassword = !hidePassword;
            });
          },
        ),
      ),
    );
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        fillColor: Color(0XFFf5f5f5),
        // fillColor: Colors.blue.shade100.withOpacity(.09),
        filled: true,
        contentPadding: EdgeInsets.only(top: 27),
        // isDense: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Color(0XFFFf6f6f6), width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Color(0XFFFf6f6f6),
            width: 1.0,
          ),
        ),

        // labelText: "Phone",
        hintText: "Enter phone",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Icon(
          Icons.phone_outlined,
          size: 17,
        ),
        prefixIconConstraints: BoxConstraints(
          minWidth: 40,
        ),
      ),
    );
  }
}
