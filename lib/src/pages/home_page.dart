import 'package:flutter/material.dart';
import 'package:flutter_form_validation/src/models/product_model.dart';
import 'package:flutter_form_validation/src/providers/products_provider.dart';

class HomePage extends StatelessWidget {
  final productProvider = ProductsProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Página Principal"),
      ),
      body: _createList(),
      floatingActionButton: _createButton(context),
    );
  }

  Widget _createList() {
    return FutureBuilder(
      future: productProvider.loadProducts(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
        if (snapshot.hasData) {
          final products = snapshot.data;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) =>
                _createProductItem(context, products[index]),
          );
        } else
          return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _createProductItem(BuildContext context, ProductModel product) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direction) {
        productProvider.deleteProduct(product.id);
      },
      child: ListTile(
        title: Text('${product.titulo} - \$${product.valor}'),
        subtitle: Text('${product.id}'),
        onTap: () =>
            Navigator.pushNamed(context, "product", arguments: product),
      ),
    );
  }

  Widget _createButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, "product"),
    );
  }
}
