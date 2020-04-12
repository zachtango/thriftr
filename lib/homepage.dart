import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './widgets/user_products.dart';
import './widgets/map.dart';
import './widgets/new_product.dart';
import './widgets/product_list.dart';
import './models/product.dart';

const url = 'https://thriftr-a3ec4.firebaseio.com/products.json';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  List<Product> _productList = [];
  List<Map> _coordList = [];
  var _isLoading1 = false;
  var _isLoading2 = false;
  var _isLoading3 = false;

  Future<List<Product>> futureProducts;

  int airCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  void _fetchProducts() {
    setState(() {
      _isLoading2 = true;
    });

    final List<Product> products = [];

    // FIXME add catch error functionality
    http.get(url).then((response) {
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      //print(json.decode(response.body));

      extractedData.forEach((k, v) =>
          products.add(Product(v['name'], v['address'], v['sellerName'], k)));

      setState(() {
        _productList = products;
        _isLoading2 = false;
      });
    });

    _fetchCoords();
  }

  void _fetchCoords() async {
    List<Map> coords = [];

    setState((){
      _isLoading3 = true;
    });

    await Future.wait(_productList.map((product) async {
      try {
        var query = product.address;
        var key = 'AIzaSyDHiIBQ_mx43wig_dWYW1-T39SusMUJzrk';
        var api =
            'https://maps.googleapis.com/maps/api/geocode/json?address=$query&key=$key';

        http.Response response = await http.get(api);
        var extractedData =
            json.decode(response.body)['results'][0]['geometry'];

        var location = extractedData['location'];

        //print(location);

        coords.add(location);

        return product;
      } catch (e) {
        //print(e);
        return product;
      }
    }));

    setState(() {
      _coordList = coords;
      _isLoading3 = false;
    });
    print(_coordList);
  }

  _addNewProduct(String name, String street, String sellerName, String city,
      String state) {
    setState(() {
      _isLoading1 = true;
    });

    final address = '${street}, ${city}, ${state}';

    // post request
    http
        .post(url,
            body: json.encode({
              'name': name,
              'address': address,
              'sellerName': sellerName,
            }))
        .then((response) {
      final newProduct = Product(
          name, address, sellerName, json.decode(response.body)['name']);

      setState(() {
        _productList.add(newProduct);
        _isLoading1 = false;
      });
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      SingleChildScrollView(
        child: _isLoading1
            ? Center(child: CupertinoActivityIndicator())
            : Column(
                children: [
                  CupertinoButton(
                    child: Text('Refresh'),
                    onPressed: () {
                      _fetchProducts();
                    },
                  ),
                  ProductList(_productList),
                ],
              ),
      ),
      _isLoading3 ? Center(child: CupertinoActivityIndicator())
          : MapView(_coordList),
      SingleChildScrollView(child: NewProduct(_addNewProduct))
    ];

    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.list)),
          BottomNavigationBarItem(icon: Icon(Icons.map)),
          BottomNavigationBarItem(icon: Icon(Icons.add)),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (BuildContext context) {
                return CupertinoPageScaffold(
                  navigationBar: CupertinoNavigationBar(
                    middle: Text('thriftr'),
                  ),
                  child: SafeArea(
                    top: false,
                    bottom: false,
                    minimum: const EdgeInsets.only(
                      left: 16,
                      top: 80,
                      bottom: 8,
                      right: 80,
                    ),
                    child: SingleChildScrollView(
                      child: _isLoading1
                          ? Center(child: CupertinoActivityIndicator())
                          : Column(
                              children: [
                                CupertinoButton(
                                  child: Text('Refresh'),
                                  onPressed: () {
                                    _fetchProducts();
                                  },
                                ),
                                ProductList(_productList),
                              ],
                            ),
                    ),
                  ),
                );
              },
            );
          case 1:
            return CupertinoTabView(
              builder: (BuildContext context) {
                return CupertinoPageScaffold(
                    navigationBar: CupertinoNavigationBar(
                      middle: Text('Listings near me'),
                    ),
                    child: _isLoading3
                        ? Center(child: CupertinoActivityIndicator())
                        : MapView(_coordList));
              },
            );
          case 2:
            return CupertinoTabView(
              builder: (BuildContext context) {
                return CupertinoPageScaffold(
                    navigationBar: CupertinoNavigationBar(
                      middle: Text('Add a new product'),
                    ),
                    child: SingleChildScrollView(
                        child: NewProduct(_addNewProduct)));
              },
            );
        }
      },
    );
  }
}
