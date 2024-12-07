import 'package:flutter/material.dart';
import 'insert_product_page.dart';
import 'product_list_page.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Main Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InsertProductPage()),
              ),
              child: Text('Insert Product'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductListPage()),
              ),
              child: Text('View Products'),
            ),
          ],
        ),
      ),
    );
  }
}
