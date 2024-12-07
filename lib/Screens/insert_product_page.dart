import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../models/product.dart';
import '../dbHelper/product_crud.dart';

class InsertProductPage extends StatelessWidget {
  final TextEditingController idController = TextEditingController();
  final TextEditingController designationController = TextEditingController();

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Insert Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: idController,
              decoration: InputDecoration(labelText: 'ID'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: designationController,
              decoration: InputDecoration(labelText: 'Designation'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final product = Product(
                  mongoId: ObjectId(),
                  id: idController.text.trim(),
                  designation: designationController.text.trim(),
                );
                await createProduct(product);
                Navigator.pop(context);
                Fluttertoast.showToast(
                  msg: "Successfully inserted product ${product.id} ${product.designation}",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              },
              child: Text('Insert'),
            ),
          ],
        ),
      ),
    );
  }
}
