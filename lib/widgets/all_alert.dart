import 'package:flutter/material.dart';
import 'package:c300_smart_inventory/api/getAPI.dart';
import 'package:c300_smart_inventory/model/AlertModel.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../constants.dart';
import 'components/alert_card.dart';

Widget buildAlert(BuildContext context) => AllAlert();

class AllAlert extends StatefulWidget {
  @override
  _AllAlertState createState() => _AllAlertState();
}

class _AllAlertState extends State<AllAlert> {
  String filterType = "today";
  DateTime today = new DateTime.now();
  String taskPop = "close";
  var monthNames = [
    "JAN",
    "FEB",
    "MAR",
    "APR",
    "MAY",
    "JUN",
    "JUL",
    "AUG",
    "SEPT",
    "OCT",
    "NOV",
    "DEC"
  ];
  CalendarController ctrlr = new CalendarController();

  List<Alert> _newAlert = List<Alert>();
  @override
  void initState() {
    super.initState();
    _populateNewAlert();
  }

  Future<void> _populateNewAlert() async {
    await Future.delayed(Duration(microseconds: 800));
    Webservice().load(Alert.all).then((newAlert) => {
          setState(() => {_newAlert = newAlert})
        });
  }

  @override
  Widget build(BuildContext context) {
    if (_newAlert.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        body: RefreshIndicator(
          onRefresh: _populateNewAlert,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today ${monthNames[today.month - 1]}, ${today.day}/${today.year}",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                  child: ListView.builder(
                      itemCount: _newAlert.length,
                      itemBuilder: (context, index) => AlertCard(
                            alert: _newAlert[index],
                            press: () {},
                          )),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
