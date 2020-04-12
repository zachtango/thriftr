import 'package:flutter/foundation.dart';

class Product{
  final String name;
  final String address;
  final String sellerName;
  final String id;
  final String imgPath;
  Map coords;

  Product(@required this.name, @required this.address, @required this.sellerName, @required this.id, @required this.imgPath, [this.coords]);

  void setCoords(inputCoords){
    coords = inputCoords;
  }
}