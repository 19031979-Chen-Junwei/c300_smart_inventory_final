import 'package:flutter/material.dart';
import 'package:c300_smart_inventory/model/Product.dart';

import '../../constants.dart';


class ItemCard extends StatelessWidget {
  final Product product;
  final Function press;
  const ItemCard({
    Key key,
    this.product,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(kDefaultPaddin),
              decoration: BoxDecoration(
                color: product.color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: "${product.description}",
                child: Image.network("http://chill.azurewebsites.net/product/${product.image}"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
            child: Text(
              product.description,
              style: TextStyle(color: kTextLightColor),
            ),
          ),
          Text(
            "Remaining: ${product.quantity}",
            style: TextStyle(fontWeight: FontWeight.bold, color: product.quantity >= 3 ? Colors.green : Colors.redAccent),
          )
        ],
      ),
    );
  }
}
