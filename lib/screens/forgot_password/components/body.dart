import 'package:commerce/helper/http.dart';
import 'package:commerce/screens/sign_in/sign_in_screen.dart';
import 'package:commerce/utilities/const.dart';
import 'package:flutter/material.dart';
import 'package:commerce/components/custom_surfix_icon.dart';
import 'package:commerce/components/default_button.dart';
import 'package:commerce/components/form_error.dart';
import 'package:commerce/components/no_account_text.dart';
import 'package:commerce/size_config.dart';

import '../../../constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                "Forgot Password",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(28),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Please enter your email and we will send \nyou a link to return to your account",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
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
  List<String> errors = [];
  String email;
  String otp;
  String password;

  bool hide = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onSaved: (newValue) => email = newValue,
            onChanged: (value) {
              email = value;
            },
            validator: (value) {
              if (value.isEmpty && !errors.contains(kEmailNullError)) {
                setState(() {
                  errors.add(kEmailNullError);
                });
              } else if (!emailValidatorRegExp.hasMatch(value) &&
                  !errors.contains(kInvalidEmailError)) {
                setState(() {
                  errors.add(kInvalidEmailError);
                });
              }
              return null;
            },
            decoration: InputDecoration(
              fillColor: Color(0XFFf5f5f5),
              filled: true,
              // labelText: "Phone",
              hintText: "Enter your phone",
              hintStyle: TextStyle(
                fontSize: 17,
                height: 1.4,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 25,
              ),

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
              prefixIcon: Icon(
                Icons.phone_outlined,
                size: 18,
              ),
              prefixIconConstraints: BoxConstraints(
                minWidth: 40,
              ),
              suffixIcon: Container(
                margin: EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(
                    width: 1,
                    color: Colors.grey.shade200,
                  )),
                ),
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () async {
                    var res = await postHttp(
                        "$baseUrl$resetMobile", {'mobile': email});
                    // print("$baseUrl$resetMobile");

                    if (!res["success"]) {
                      final snackBar = SnackBar(
                        content: Text("No account found"),
                        backgroundColor: Colors.red,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      final snackBar = SnackBar(
                        content: Text("Otp sent"),
                        backgroundColor: Colors.green,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: const Text(
                    'Send OTP',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(15)),
          TextFormField(
            obscureText: true,
            onSaved: (newValue) {},
            onChanged: (value) {
              otp = value;
            },
            validator: (value) {
              if (value.isEmpty) {
                return "";
              }
              return null;
            },
            decoration: InputDecoration(
              fillColor: Color(0XFFf5f5f5),
              filled: true,
              hintStyle: TextStyle(
                fontSize: 17,
                height: 1.4,
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              // labelText: "OTP",
              hintText: "Enter OTP",
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
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              prefixIcon: Icon(
                Icons.phone_iphone,
                size: 18,
              ),
              prefixIconConstraints: BoxConstraints(
                minWidth: 40,
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(15)),
          TextFormField(
            obscureText: hide,
            onSaved: (newValue) {},
            onChanged: (value) {
              password = value;
            },
            validator: (value) {
              if (value.isEmpty) {
                return "";
              }
              return null;
            },
            decoration: InputDecoration(
              hintStyle: TextStyle(
                fontSize: 17,
                height: 1.4,
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              fillColor: Color(0XFFf5f5f5),
              filled: true,
              // labelText: "Password",
              hintText: "Enter your password",
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
              // If  you are using latest version of flutter then lable text and hint text shown like this
              // if you r using flutter less then 1.20.* then maybe this is not working properly
              // floatingLabelBehavior: FloatingLabelBehavior.always,
              // suffixIcon: GestureDetector(
              //   onTap: () {
              //     setState(() {
              //       hide = !hide;
              //     });
              //   },
              //   child: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
              // ),

              prefixIcon: Icon(
                Icons.lock,
                size: 18,
              ),
              prefixIconConstraints: BoxConstraints(
                minWidth: 40,
              ),
            ),
          ),
          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight * 0.07),
          DefaultButton(
            text: "Continue",
            press: () async {
              if (_formKey.currentState.validate()) {
                var res = await postHttp("$baseUrl$resetPassword",
                    {'mobile': email, "otp": otp, "password": password});
                if (!res["success"]) {
                  final snackBar = SnackBar(
                    content: Text("Invalid OTP"),
                    backgroundColor: Colors.red,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  final snackBar = SnackBar(
                    content: Text("Password reset"),
                    backgroundColor: Colors.green,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.pushNamed(context, SignInScreen.routeName);
                }
              }
            },
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          NoAccountText(),
        ],
      ),
    );
  }
}
