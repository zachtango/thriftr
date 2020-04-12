import 'package:flutter/material.dart';


class NewProduct extends StatelessWidget{
  final Function addProduct;
  final nameController = TextEditingController();
  final streetController = TextEditingController();
  final sellerNameController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();

  NewProduct(this.addProduct);

  @override
  Widget build(BuildContext context){
    return Card(
      child: Column(children: [
        TextField(
          decoration: InputDecoration(
              labelText: 'Product Name'
          ),
          controller: nameController
        ),
        TextField(
          decoration: InputDecoration(
              labelText: 'Your Street'
          ),
          controller: streetController
        ),
        TextField(
            decoration: InputDecoration(
                labelText: 'Your City'
            ),
            controller: cityController
        ),
        TextField(
            decoration: InputDecoration(
                labelText: 'Your State'
            ),
            controller: stateController
        ),
        TextField(
          decoration: InputDecoration(
              labelText: 'Your Name'
          ),
          controller: sellerNameController
        ),
        FlatButton(
          child: Text('Add Product'),
          textColor: Colors.purple,
          onPressed: () async {
            addProduct(nameController.text, streetController.text, sellerNameController.text, cityController.text, stateController.text);

          },
        ),
      ]),
    );
  }
}