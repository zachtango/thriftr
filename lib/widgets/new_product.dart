import 'package:flutter/material.dart';



class NewProduct extends StatelessWidget{
  final Function addProduct;
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final sellerNameController = TextEditingController();
  var _isLoading = false;

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
              labelText: 'Your Address'
          ),
          controller: addressController
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
          onPressed: () {
            addProduct(nameController.text, addressController.text, sellerNameController.text);
          },
        ),
      ]),
    );
  }
}