import 'package:flutter/material.dart';


class NewProduct extends StatelessWidget{
  final Function addProduct;
  final nameController = TextEditingController();
  final streetController = TextEditingController();
  final sellerNameController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final imgController = TextEditingController();

  NewProduct(this.addProduct);

  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.only(top: 100.0),
      child: Card(
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
          TextField(
              decoration: InputDecoration(
                  labelText: 'Picture Link'
              ),
              controller: imgController
          ),
          FlatButton(
            child: Text('Add Product'),
            textColor: Colors.purple,
            onPressed: () async {
              addProduct(nameController.text, streetController.text, sellerNameController.text, cityController.text, stateController.text);

            },
          ),
        ]),
      ),
    );
  }
}