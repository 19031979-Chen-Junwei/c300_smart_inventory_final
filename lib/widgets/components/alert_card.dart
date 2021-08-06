import 'package:c300_smart_inventory/page/fingerprint_Login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:c300_smart_inventory/model/AlertModel.dart';
import 'package:c300_smart_inventory/model/Product.dart';
import 'package:c300_smart_inventory/page/home_page.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../constants.dart';
import 'package:intl/intl.dart';

DateTime now = DateTime.now();
String date = DateFormat('yyyy-MM-dd').format(now);
String time = DateFormat('HH:mm:ss').format(now);

class AlertCard extends StatelessWidget {
  final Alert alert;
  final Function press;
  const AlertCard({
    Key key,
    this.alert,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _updateQuantity() async {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      };
      var request = http.Request(
          'PUT',
          Uri.parse(
              'https://chill.azurewebsites.net/api/stock/${alert.id.toString()}'));
      request.body = json.encode({"Id": alert.id, "Quantity": 10});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    }

    _postDateTime() async {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token,
      };
      var request = http.Request(
          'POST', Uri.parse('https://chill.azurewebsites.net/api/stock/'));
      request.body = json.encode({
        "ProductId": alert.id,
        "RestockDate": date + "T" + time, //Get now Data time in this format
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    }

    Color color = Colors.red;
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.3,
      child: Container(
        height: 80,
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.03),
              offset: Offset(0, 9),
              blurRadius: 20,
              spreadRadius: 1)
        ]),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: color, width: 4)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  alert.description,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                Text(
                  "${alert.shelf.toString().trim()} : ${alert.isle.toString().trim()}",
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                )
              ],
            ),
            Expanded(
              child: Container(),
            ),
            Container(
              height: 50,
              width: 5,
              color: color,
            )
          ],
        ),
      ),
      secondaryActions: [
        IconSlideAction(
          caption: "replenished",
          color: Colors.greenAccent,
          icon: Icons.done_outline_rounded,
          onTap: () async {
            // update quantity
            _updateQuantity();
            _postDateTime();
          },
        ),
        // IconSlideAction(
        //   caption: "Delete",
        //   color: color,
        //   icon: Icons.edit,
        //   onTap: () {},
        // )
      ],
    );
  }
}
