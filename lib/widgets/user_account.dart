import 'package:c300_smart_inventory/constants.dart';
import 'package:c300_smart_inventory/page/fingerprint_Login_page.dart';
import 'package:c300_smart_inventory/page/welcomePage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:c300_smart_inventory/widgets/components/profile_menu.dart';
import 'package:url_launcher/url_launcher.dart';

Widget buildAccount(BuildContext context) => UserAccount();

class UserAccount extends StatefulWidget {
  @override
  _UserAccountState createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          // ProfilePic(),
          Text("Thank you for using Smart Inventory",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          SizedBox(height: 20),
          Text(username,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          SizedBox(height: 20),
          // ProfileMenu(
          //   text: "My Account",
          //   icon: "assets/icons/User Icon.svg",
          //   press: () => {},
          // ),
          // ProfileMenu(
          //   text: "Settings",
          //   icon: "assets/icons/Settings.svg",
          //   press: () {
          //     Navigator.of(context).pushReplacement(
          //       MaterialPageRoute(builder: (context) => SettingPage()),
          //     );
          //   },
          // ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () async {
              var url = "https://chill.azurewebsites.net/";
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool("haveAuth", false);
              prefs.setString("username", "");
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => FingerprintPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
