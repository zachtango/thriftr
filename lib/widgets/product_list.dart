import 'package:flutter/cupertino.dart';

import '../models/product.dart';

class ProductList extends StatelessWidget {
  List<Product> productList;

  ProductList(this.productList);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: productList.map((product) {
        return Row(children: [
          ProductWidget(product.sellerName, product.address, product.name)
        ]);
      }).toList(),
    );
  }
}

class ProductWidget extends StatelessWidget {
  String sellerName;
  String address;
  String productName;

  ProductWidget(this.sellerName, this.address, this.productName);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(CupertinoIcons.photo_camera, size: 50),
          Text(this.productName),
          Text('Seller: ' + this.sellerName),
          Text(this.address)
        ],
      ),
    );
  }
}
