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
        title: Text("Create new address"),
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
                  buildFirstNameFormField(),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  buildLastNameFormField(),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  buildEmailFormField(),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  buildMobileFormField(),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  buildCityFormField(),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  buildAddressFormField(),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  buildPostCodeFormField(),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  buildRegionFormField(),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  DefaultButton(
                    text: "Save",
                    press: () async {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();

                        var data =
                            await postAuthHttp("$baseUrl$createAddress", {
                          "first_name": firstName,
                          "last_name": lastName,
                          "mobile": mobile,
                          "city": city,
                          "email": email,
                          "zip": postCode,
                          "street_address": address,
                          "region": region
                        });
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
        labelText: "First Name",
        hintText: "Enter your first name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.person),
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
        labelText: "Last Name",
        hintText: "Enter your last name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.person),
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
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.person),
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
        labelText: "Mobile Number",
        hintText: "Enter your mobile number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.person),
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
        labelText: "City",
        hintText: "Enter city",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.person),
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
        labelText: "Street Address",
        hintText: "Enter your street address",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.person),
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
        labelText: "Post Code",
        hintText: "Enter your post code",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.person),
      ),
    );
  }

  DropdownButton buildRegionFormField() {
    return DropdownButton(
        value: region,
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
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
              width: SizeConfig.screenWidth * 0.75,
              child: Text("Inside Dhaka"),
            ),
          ),
          DropdownMenuItem(
              value: "Outside Dhaka",
              child: Container(child: Text("Outside Dhaka"))),
        ]);
  }
}
