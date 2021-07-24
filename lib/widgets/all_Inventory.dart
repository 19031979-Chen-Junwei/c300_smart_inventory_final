import 'package:flutter/material.dart';
import 'package:c300_smart_inventory/api/getAPI.dart';
import 'package:c300_smart_inventory/model/Product.dart';

import '../constants.dart';
import 'components/item_card.dart';

Widget buildCate(BuildContext context) => Body();

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Product> _newProduct = List<Product>();

  @override
  void initState() {
    super.initState();
    _populateNewProduct();
  }

  Future<void> _populateNewProduct() async {
    await Future.delayed(Duration(microseconds: 800));
    Webservice().load(Product.all).then((newProduct) => {
          setState(() => {_newProduct = newProduct})
        });
  }

  @override
  Widget build(BuildContext context) {
    if (_newProduct.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        body: RefreshIndicator(
          onRefresh: _populateNewProduct,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPaddin, vertical: kDefaultPaddin),
                child: Text(
                  "Inventory",
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              // Categories(),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                  child: GridView.builder(
                      itemCount: _newProduct.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: kDefaultPaddin,
                        crossAxisSpacing: kDefaultPaddin,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) => ItemCard(
                            product: _newProduct[index],
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
