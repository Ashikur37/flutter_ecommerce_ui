import 'dart:convert';

import 'package:commerce/components/default_button.dart';
import 'package:commerce/constants.dart';
import 'package:commerce/helper/http.dart';
import 'package:commerce/screens/address/address_list.dart';
import 'package:commerce/utilities/const.dart';
import 'package:flutter/material.dart';

import '../../size_config.dart';

class CreateAddress extends StatefulWidget {
  static String routeName = "/create_address";

  @override
  _CreateAddressState createState() => _CreateAddressState();
}

class _CreateAddressState extends State<CreateAddress> {
  final _formKey = GlobalKey<FormState>();
  String firstName;
  String lastName;
  String email;
  String mobile;
  String region = "Inside Dhaka";
  String city;
  String address;
  String postCode;
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
        title: Text(
          "Create new address",
          style: TextStyle(color: kPrimaryColor),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(15)),
                  buildFirstNameFormField(),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  buildLastNameFormField(),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  buildEmailFormField(),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  buildMobileFormField(),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  buildCityFormField(),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  buildAddressFormField(),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  buildPostCodeFormField(),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0XFFf5f5f5),
                    ),
                    child: buildRegionFormField(),
                  ),
                  SizedBox(height: getProportionateScreenHeight(30)),
                  DefaultButton(
                    text: "Save",
                    press: () async {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();

                        var data = await postAuthHttp(
                          "$baseUrl$createAddress",
                          jsonEncode({
                            "first_name": firstName,
                            "last_name": lastName,
                            "mobile": mobile,
                            "city": city,
                            "email": email,
                            "zip": postCode,
                            "street_address": address,
                            "region": region
                          }),
                        );
                        Navigator.pushNamed(context, AddressList.routeName);
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
        fillColor: Color(0XFFf5f5f5),
        filled: true,
        contentPadding: EdgeInsets.only(top: 35),
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
        prefixIcon: Icon(
          Icons.person,
          size: 20,
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
        fillColor: Color(0XFFf5f5f5),
        filled: true,
        contentPadding: EdgeInsets.only(top: 35),
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
        prefixIcon: Icon(
          Icons.person,
          size: 20,
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Enter email");
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: "Enter email");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        fillColor: Color(0XFFf5f5f5),
        filled: true,
        contentPadding: EdgeInsets.only(top: 35),
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
        hintText: "Enter email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Icon(Icons.email, size: 18),
      ),
    );
  }

  TextFormField buildMobileFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => mobile = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Enter mobile number");
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: "Enter mobile number");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        fillColor: Color(0XFFf5f5f5),
        filled: true,
        contentPadding: EdgeInsets.only(top: 35),
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
        hintText: "Enter mobile number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Icon(Icons.add_call, size: 18),
      ),
    );
  }

  TextFormField buildCityFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => city = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Enter city");
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: "Enter city");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        fillColor: Color(0XFFf5f5f5),
        filled: true,
        contentPadding: EdgeInsets.only(top: 35),
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
        hintText: "Enter city",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Icon(Icons.location_city, size: 20),
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => address = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Enter street address");
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: "Enter street address");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        fillColor: Color(0XFFf5f5f5),
        filled: true,
        contentPadding: EdgeInsets.only(top: 35),
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
        hintText: "Enter street address",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Icon(Icons.add_location, size: 18),
      ),
    );
  }

  TextFormField buildPostCodeFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => postCode = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: "Enter post code");
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: "Enter post code");
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        fillColor: Color(0XFFf5f5f5),
        filled: true,
        contentPadding: EdgeInsets.only(top: 35),
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
        hintText: "Enter post code",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        prefixIcon: Icon(Icons.business, size: 18),
      ),
    );
  }

  DropdownButton buildRegionFormField() {
    return DropdownButton(
        icon: Icon(Icons.expand_more),
        value: region,
        elevation: 16,
        style: const TextStyle(
          color: Color(0XFF606060),
          fontSize: 16,
        ),
        underline: Container(
          height: 0,
          color: Colors.white,
        ),
        onChanged: (newValue) {
          setState(() {
            region = newValue;
          });
        },
        items: [
          DropdownMenuItem(
            value: "Inside Dhaka",
            child: Container(
              width: SizeConfig.screenWidth * 0.74,
              child: Text("Inside Dhaka"),
            ),
          ),
          DropdownMenuItem(
              value: "Outside Dhaka",
              child: Container(child: Text("Outside Dhaka"))),
        ]);
  }
}
