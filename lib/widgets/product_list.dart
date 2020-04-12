import 'package:flutter/cupertino.dart';

import '../models/product.dart';

class ProductList extends StatelessWidget {
  List<Product> productList;

  ProductList(this.productList);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: productList.map((product) {
        return Column(children: [
          Row(children: [
            ProductWidget(product.sellerName, product.address, product.name,
                product.imgPath)
          ]),
          SizedBox(height: 20)
        ]);
      }).toList(),
    );
  }
}

class ProductWidget extends StatelessWidget {
  String sellerName;
  String address;
  String productName;
  String path;

  ProductWidget(this.sellerName, this.address, this.productName, this.path);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: <Widget>[
          Image.asset(path, width: 50, height: 50),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              children: <Widget>[
                Text(this.productName),
                Text('Seller: ' + this.sellerName),
                Text(this.address)
              ],
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
        ],
      ),
    );
  }
}
