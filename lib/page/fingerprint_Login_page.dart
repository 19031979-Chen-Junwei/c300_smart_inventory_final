import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:c300_smart_inventory/api/local_auth_api.dart';
import 'package:c300_smart_inventory/model/Product.dart';
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
String token = "";

class FingerprintPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  SizedBox(height: size.height * 0.03),
                  SvgPicture.asset(
                    "assets/icons/logo.svg",
                  ),
                  SizedBox(height: size.height * 0.12),
                  Text(
                    "LOGIN",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  SizedBox(height: size.height * 0.03),
                  TextFieldContainer(
                    child: TextField(
                      controller: usernameController,
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: kPrimaryColor,
                        ),
                        hintText: "Employee ID",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextFieldContainer(
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        hintText: "Password",
                        icon: Icon(
                          Icons.lock,
                          color: kPrimaryColor,
                        ),
                        suffixIcon: Icon(
                          Icons.visibility,
                          color: kPrimaryColor,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
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
                          "Login",
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1)),
                        ),
                        onPressed: () async {
                          var headers = {
                            'Content-Type': 'application/json',
                          };
                          var request = http.Request(
                              'POST',
                              Uri.parse(
                                  'http://chill.azurewebsites.net/api/name/authenticate'));
                          request.body = json.encode(
                              {"username": usernameController.text, "password": passwordController.text});
                          request.headers.addAll(headers);

                          http.StreamedResponse response = await request.send();

                          // start post
                          // var headers = {'Content-Type': 'application/json'};
                          // var request = http.Request(
                          //     'POST',
                          //     Uri.parse(
                          //         'https://chill.azurewebsites.net/api/Members/authentication'));
                          // request.body = json.encode({
                          //   "EmployeeNo": usernameController.text,
                          //   "password": passwordController.text
                          // });
                          // request.headers.addAll(headers);

                          // http.StreamedResponse response = await request.send();

                          if (response.statusCode == 200) { // login success
                            var saveToken =
                                await response.stream.bytesToString();
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setBool("haveAuth", true);
                            prefs.setString("username", usernameController.text);
                            prefs.setString("password", passwordController.text);
                            token = saveToken;
                            // Alert
                            Alert(
                              context: context,
                              type: AlertType.success,
                              title: "Use Biometric",
                              desc: "Do you wish to able biometric login?",
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "Yes",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()),
                                    );
                                    prefs.setBool("useBio", true);
                                  },
                                  width: 120,
                                ),
                                DialogButton(
                                  child: Text(
                                    "No",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()),
                                    );
                                    prefs.setBool("useBio", false);
                                  },
                                  width: 120,
                                )
                              ],
                            ).show();
                            //Alert end
                          } else {
                            Alert(
                                    context: context,
                                    title: "Login Fail",
                                    desc: "Incorrect username or password")
                                .show();
                            print(response.reasonPhrase);
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
