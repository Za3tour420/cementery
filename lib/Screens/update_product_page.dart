import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../dbHelper/product_crud.dart';
import '../models/product.dart';

class UpdateProductPage extends StatefulWidget {
  final Product product;

  UpdateProductPage({required this.product});

  @override
  _UpdateProductPageState createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _idController;
  late TextEditingController _designationController;

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController(text: widget.product.id);
    _designationController = TextEditingController(text: widget.product.designation);
  }

  @override
  void dispose() {
    _idController.dispose();
    _designationController.dispose();
    super.dispose();
  }

  Future<void> _updateProduct() async {
    if (_formKey.currentState!.validate()) {
      final updatedProduct = Product(
        mongoId: widget.product.mongoId,
        id: _idController.text,
        designation: _designationController.text,
      );
      await updateProduct(updatedProduct);
      Fluttertoast.showToast(
                  msg: "Successfully updated product ${updatedProduct.id} ${updatedProduct.designation}",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _idController,
                decoration: InputDecoration(labelText: 'Product ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _designationController,
                decoration: InputDecoration(labelText: 'Designation'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a designation';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateProduct,
                child: Text('Update Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
