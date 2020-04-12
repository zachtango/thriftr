import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './new_product.dart';
import './product_list.dart';
import '../models/product.dart';

const url = 'https://thriftr-a3ec4.firebaseio.com/products.json';

class UserProducts extends StatelessWidget{
  final _isLoading;
  final productList;
  final Function addNewProduct;
  final Function fetchProducts;

  UserProducts(this._isLoading, this.productList, this.addNewProduct, this.fetchProducts);

  @override
  Widget build(BuildContext context){
    return _isLoading ? Center(
      child: CircularProgressIndicator()
    ) : Column(
      children: [
        FlatButton(
          child: Text('Refresh'),
          textColor: Colors.purple,
          onPressed: (){
            fetchProducts();
          }
        ),
        NewProduct(addNewProduct),
        ProductList(productList),
      ]
    );
  }

}