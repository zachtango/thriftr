import 'package:flutter/cupertino.dart';

import '../models/product.dart';

class ProductList extends StatelessWidget{
  List<Product> productList;

  ProductList(this.productList);

  @override
  Widget build(BuildContext context){

    return Column(
      children: productList.map((product){
        return Row(
          children: [
            Text(product.name),
            Text(product.address),
            Text(product.sellerName),
          ]
        );
      }).toList(),
    );
  }

}
