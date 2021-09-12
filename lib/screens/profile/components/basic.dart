import 'dart:convert';

import 'package:commerce/components/default_button.dart';
import 'package:commerce/constants.dart';
import 'package:commerce/helper/auth.dart';
import 'package:commerce/helper/http.dart';
import 'package:commerce/screens/address/address_list.dart';
import 'package:commerce/screens/profile/profile_screen.dart';
import 'package:commerce/utilities/const.dart';
import 'package:flutter/material.dart';

import '../../../size_config.dart';

class BasicProfile extends StatefulWidget {
  static String routeName = "/basic_profile";

  @override
  _BasicProfileState createState() => _BasicProfileState();
}

class _BasicProfileState extends State<BasicProfile> {
  final _formKey = GlobalKey<FormState>();
  String firstName;
  String lastName;
  bool isLoad = true;
  getUser() async {
    var user = await localGetUser();
    print(user);
    if (isLoad) {
      setState(() {
        firstName = user["name"];
        lastName = user["lastname"];
        isLoad = false;
      });
    }
  }

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
    getUser();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Basic Profile",
          style: TextStyle(color: kPrimaryColor),
        ),
      ),
      body: SafeArea(
        child: isLoad
            ? CircularProgressIndicator()
            : Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        buildFirstNameFormField(),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        buildLastNameFormField(),
                        SizedBox(height: getProportionateScreenHeight(50)),
                        DefaultButton(
                          text: "Save",
                          press: () async {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();

                              var data = await postAuthHttp(
                                  "$baseUrl$updateBasic",
                                  jsonEncode({
                                    "first_name": firstName,
                                    "last_name": lastName,
                                  }));
                              await localSetUser(data["user"]);
                              final snackBar = SnackBar(
                                content: Text(data["msg"]),
                                backgroundColor: Colors.greenAccent,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              Navigator.pushNamed(
                                  context, ProfileScreen.routeName);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      initialValue: firstName,
      keyboardType: TextInputType.text,
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Enter firstname");
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: "Enter firstname");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 27),
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
        labelText: "First Name",
        labelStyle: TextStyle(color: Color(0XFF606060)),
        hintText: "Enter your first name",
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Icon(
          Icons.person,
          size: 22,
        ),
        prefixIconConstraints: BoxConstraints(
          minWidth: 40,
        ),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      initialValue: lastName,
      keyboardType: TextInputType.text,
      onSaved: (newValue) => lastName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Enter lastname");
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: "Enter lastname");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 27),
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
        labelText: "Last Name",
        hintText: "Enter your last name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Icon(
          Icons.person,
          size: 22,
        ),
        prefixIconConstraints: BoxConstraints(
          minWidth: 40,
        ),
      ),
    );
  }
}
