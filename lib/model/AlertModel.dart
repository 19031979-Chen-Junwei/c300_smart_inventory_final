import 'package:c300_smart_inventory/page/fingerprint_Login_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:c300_smart_inventory/api/getAPI.dart';
Iterable list2;
class Alert {
  final String description, isle, shelf;
  final int id, quantity;
  final Color color;
  
  Alert(
    {this.description,
    this.isle,
    this.shelf,
    this.id,
    this.quantity,
    this.color = Colors.white,
  });

  
  factory Alert.fromJson(Map<String,dynamic> json) {
    return Alert(
      description: json['description'].toString().trim(), 
      isle: json['isle'], 
      shelf: json['shelf'], 
      id: json['id'],
      quantity : json['quantity'],
    );
  }

   static Resource<List<Alert>> get all {
    
    return Resource(
      url: "http://chill.azurewebsites.net/api/stock",
      tk: token,
      parse: (response) {
        final result = json.decode(response.body); 
        list2 = result;
        return list2.map((model) => Alert.fromJson(model)).toList();
      }
    );

  }
}
