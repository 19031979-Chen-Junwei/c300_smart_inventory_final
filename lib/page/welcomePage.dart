import 'package:c300_smart_inventory/api/local_auth_api.dart';
import 'package:c300_smart_inventory/model/Product.dart';
import 'package:c300_smart_inventory/page/fingerprint_Login_page.dart';
import 'package:c300_smart_inventory/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:c300_smart_inventory/page/home_page.dart';
import 'dart:convert';
import '../constants.dart';
import '../text_field_container.dart';

TextEditingController usernameController = new TextEditingController();
TextEditingController passwordController = new TextEditingController();
bool haveAuth = false;
String username = "";
// String username2 = "";

getData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  username = prefs.getString("username");
  haveAuth = prefs.getBool("haveAuth") ?? false;
  print(username)
;  // username2 = prefs.getString("username");
}


// @override
// void initState(){
//   getData();
// }

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getData();
    // getProductData();
    // setProductList2zero();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/images/main_top.png",
                width: size.width * 0.35,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                "assets/images/login_bottom.png",
                width: size.width * 0.4,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "WELCOME TO",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        color: Color.fromRGBO(80, 65, 113, 1)),
                  ),
                  Text(
                    "SMART INVENTORY",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        color: Color.fromRGBO(80, 65, 113, 1)),
                  ),
                  SizedBox(height: 50),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: size.width * 0.8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(29),
                      child: FlatButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        color: kPrimaryColor,
                        child: Text(
                          "Get Started",
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1)),
                        ),
                        onPressed: () async {
                          print(haveAuth);
                          if (!haveAuth) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => FingerprintPage()),
                            );
                          } else {
                            final isAuthenticated =
                                await LocalAuthApi.authenticate();
                            if (isAuthenticated) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                              );
                            } else {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => FingerprintPage()),
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
