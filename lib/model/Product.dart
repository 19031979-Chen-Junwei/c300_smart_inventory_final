import 'package:c300_smart_inventory/page/fingerprint_Login_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:c300_smart_inventory/api/getAPI.dart';

class Product {
  final String description, image;
  final int id, quantity;
  final Color color;
  
  Product(
    {this.description,
    this.image,
    this.id,
    this.quantity,
    this.color = Colors.white,
  });

  
  factory Product.fromJson(Map<String,dynamic> json) {
    return Product(
      description: json['description'].toString().trim(), 
      image: json['image'], 
      id: json['id'],
      quantity : json['quantity'],
    );
  }

   static Resource<List<Product>> get all {
    
    return Resource(
      url: "http://chill.azurewebsites.net/api/location",
      tk: token,
      parse: (response) {
        final result = json.decode(response.body); 
        Iterable list = result;
        return list.map((model) => Product.fromJson(model)).toList();
      }
    );

  }
}
