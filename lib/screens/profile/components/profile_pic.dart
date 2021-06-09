import 'package:commerce/helper/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({
    Key key,
  }) : super(key: key);

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  String username = "";
  String phone = "";
  getUser() async {
    var user = await localGetUser();
    setState(() {
      username = '${user["name"]}  ${user["lastname"]}';
      phone = user["email"];
    });
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    return Column(
      children: [
        SizedBox(
          height: 115,
          width: 115,
          child: Stack(
            fit: StackFit.expand,
            overflow: Overflow.visible,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage("assets/images/user.png"),
              ),
              // Positioned(
              //   right: -16,
              //   bottom: 0,
              //   child: SizedBox(
              //     height: 46,
              //     width: 46,
              //     child: FlatButton(
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(50),
              //         side: BorderSide(color: Colors.white),
              //       ),
              //       color: Color(0xFFF5F6F9),
              //       onPressed: () {},
              //       child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
        Text(
          username,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        Text(phone),
      ],
    );
  }
}
