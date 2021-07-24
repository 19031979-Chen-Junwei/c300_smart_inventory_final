import 'package:c300_smart_inventory/constants.dart';
import 'package:c300_smart_inventory/widgets/user_account.dart';
import 'package:c300_smart_inventory/widgets/all_alert.dart';
import 'package:c300_smart_inventory/widgets/all_Inventory.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final tabs = [
      Center(child: buildAlert(context)),
      Center(child: buildCate(context)),
      Center(child: buildAccount(context)),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("SMART INVENTORY"),
        backgroundColor: kPrimaryColor,
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: kPrimaryColor,
        // type: BottomNavigationBarType.shifting,
        iconSize: 30,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Alert",
            // backgroundColor: kPrimaryColor
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_rounded),
            label: "Inventory",
            // backgroundColor: Colors.blueGrey
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Account",
            // backgroundColor: Colors.blueGrey
          )
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
