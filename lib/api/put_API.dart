import 'dart:convert';

import 'package:http/http.dart' as http;

var request = http.Request(
    'PUT', Uri.parse('http://chill.azurewebsites.net/api/stock/4'));
var body = request.body = json
    .encode({"Id": 4, "Quantity": 10, "RestockDate": "2021-06-27T02:32:00"});

sendPut() async {
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}
