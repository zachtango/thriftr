import 'package:flutter/material.dart';

import './widgets/user_products.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('First App'),
      ),
      body: SingleChildScrollView(
        child: UserProducts()
      )
    );
  }
}