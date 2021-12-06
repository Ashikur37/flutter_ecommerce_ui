import 'package:commerce/helper/http.dart';
import 'package:commerce/screens/otp/otp_screen.dart';
import 'package:commerce/utilities/const.dart';
import 'package:flutter/material.dart';
import 'package:commerce/components/custom_surfix_icon.dart';
import 'package:commerce/components/default_button.dart';
import 'package:commerce/components/form_error.dart';
import 'package:commerce/screens/complete_profile/complete_profile_screen.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class SignUpForm extends StatefulWidget {
  final Function showMessage;

  const SignUpForm({Key key, this.showMessage}) : super(key: key);
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  String firstName;
  String lastName;
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
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          buildMobileFormField(),
          SizedBox(height: getProportionateScreenHeight(15)),
          buildPasswordFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Continue",
            press: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                // if all are valid then go to success screen
                //send otp
                var res =
                    await postHttp("$baseUrl$registerOtp", {'mobile': email});
                if (!res["success"]) {
                  widget.showMessage(res["message"], Colors.redAccent);
                  return;
                }
                Navigator.pushNamed(
                  context,
                  OtpScreen.routeName,
                  arguments: OtpArguments(firstName, lastName, email, password),
                );
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
        password = value;
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
          child: Icon(
            Icons.lock,
            size: 18,
          ),
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

  TextFormField buildMobileFormField() {
    return TextFormField(
      textInputAction: TextInputAction.go,
      keyboardType: TextInputType.text,
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

        hintText: "Enter phone",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Icon(
          Icons.phone_outlined,
          size: 18,
        ),
        prefixIconConstraints: BoxConstraints(
          minWidth: 40,
        ),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => firstName = newValue,
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

        // labelText: "First Name",
        hintText: "Enter first name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Icon(
          Icons.person,
          size: 20,
        ),
        prefixIconConstraints: BoxConstraints(
          minWidth: 40,
        ),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => lastName = newValue,
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
        }
        // else if (!emailValidatorRegExp.hasMatch(value)) {
        //   addError(error: kInvalidEmailError);
        //   return "";
        // }
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

        hintText: "Enter last name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Icon(
          Icons.person,
          size: 20,
        ),
        prefixIconConstraints: BoxConstraints(
          minWidth: 40,
        ),
      ),
    );
  }
}
