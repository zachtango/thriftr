import 'package:flutter/foundation.dart';

class Product{
  final String name;
  final String address;
  final String sellerName;
  final String id;
  Map coords;

  Product(@required this.name, @required this.address, @required this.sellerName, @required this.id, [this.coords]);

  void setCoords(inputCoords){
    coords = inputCoords;
  }
}