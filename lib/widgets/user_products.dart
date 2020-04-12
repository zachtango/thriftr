import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './new_product.dart';
import './product_list.dart';
import '../models/product.dart';

const url = 'https://thriftr-a3ec4.firebaseio.com/products.json';

class UserProducts extends StatefulWidget{
  @override
  _UserProductsState createState() => _UserProductsState();

}

class _UserProductsState extends State<UserProducts>{
  List<Product> _productList = [];
  var _isLoading = false;
  Future<List<Product>> futureProducts;

  @override
  void initState(){
    super.initState();
    _fetchProducts();
  }

  _fetchProducts(){
    setState((){
      _isLoading = true;
    });

    final List<Product> products = [];

    // FIXME add catch error functionality
    http.get(url).then((response){
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      //print(json.decode(response.body));

      extractedData.forEach((k, v) =>
          products.add(Product(v['address'], v['name'], v['sellerName'], k))
      );

      setState((){
        _productList = products;
        _isLoading = false;
      });
    });
  }

  _addNewProduct(String name, String address, String sellerName){
    setState((){
      _isLoading = true;
    });

    // post request
    http.post(url, body: json.encode({
      'name': name,
      'address': address,
      'sellerName': sellerName,
    })).then((response){
      print(json.decode(response.body)['name']);

      final newProduct = Product(name, address, sellerName, /*json.decode(response.body)['name']*/ '');
      setState((){
        _productList.add(newProduct);
        _isLoading = false;
      });
    });
  }

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
            _fetchProducts();
          }
        ),
        NewProduct(_addNewProduct),
        ProductList(_productList),

      ]
    );
  }

}