import 'package:flutter/cupertino.dart';
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

  Future<List<Product>> futureProducts;

  int airCount = 0;

  @override
  void initState(){
    super.initState();
    _fetchProducts();
  }

  void _fetchProducts(){
    setState((){
      _isLoading2 = true;
    });

    final List<Product> products = [];

    // FIXME add catch error functionality
    http.get(url).then((response){
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      //print(json.decode(response.body));

      extractedData.forEach((k, v) =>
          products.add(Product(v['name'], v['address'], v['sellerName'], k))
      );

      setState((){
        _productList = products;
        _isLoading2 = false;
      });
    });

    _fetchCoords();
  }

  void _fetchCoords() async{

    List<Map> coords = [];

    await Future.wait(_productList.map((product) async{
      try {
        var query = product.address;
        var key = 'AIzaSyDHiIBQ_mx43wig_dWYW1-T39SusMUJzrk';
        var api = 'https://maps.googleapis.com/maps/api/geocode/json?address=$query&key=$key';

        http.Response response = await http.get(api);
        var extractedData = json.decode(response.body)['results'][0]['geometry'];

        var location = extractedData['location'];

        //print(location);

        coords.add(location);

        return product;
      } catch(e){

        //print(e);
        return product;
      }
    }));

    setState((){
      _coordList = coords;
    });
    print(_coordList);
  }

  _addNewProduct(String name, String street, String sellerName, String city, String state){
    setState((){
      _isLoading1 = true;
    });

    final address = '${street}, ${city}, ${state}';

    // post request
    http.post(url, body: json.encode({
      'name': name,
      'address': address,
      'sellerName': sellerName,
    })).then((response) {

      final newProduct = Product(name, address, sellerName, json.decode(response.body)['name']);

      setState((){
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
  Widget build(BuildContext context){
    List<Widget> _widgetOptions = <Widget>[
      SingleChildScrollView(
        child: _isLoading1 ? Center(
            child: CupertinoActivityIndicator()) : Column(
          children: [
            CupertinoButton(
              child: Text('Refresh'),
              onPressed: (){
                _fetchProducts();
              },
            ),
            ProductList(_productList),
          ],
        ),
      ),
      MapView(),
      SingleChildScrollView(
        child: NewProduct(_addNewProduct)
      )
    ];

    return CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
              items: <BottomNavigationBarItem> [
                BottomNavigationBarItem(icon: Icon(CupertinoIcons.add)),
                BottomNavigationBarItem(icon: Icon(CupertinoIcons.add)),
                BottomNavigationBarItem(icon: Icon(CupertinoIcons.add)),
              ],
            ),
            tabBuilder: (BuildContext context, int index) {
              return CupertinoTabView(
                builder: (BuildContext context) {
                  return CupertinoPageScaffold(
                    navigationBar: CupertinoNavigationBar(
                      middle: Text('Page 1 of tab $index'),
                    ),
                    child: _widgetOptions[index]
                  );
                },
              );
            },
          );
  }
}