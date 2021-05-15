import 'package:flutter/material.dart';

import 'package:flutter_form_validation/src/models/product_model.dart';
import 'package:flutter_form_validation/src/providers/products_provider.dart';

import 'package:flutter_form_validation/src/utils/utils.dart' as utils;

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final productsProvider = ProductsProvider();
  final formKey = GlobalKey<FormState>();
  ProductModel product = ProductModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Producto"),
        actions: [
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _createName(),
                _createPrice(),
                _createAvailable(),
                _createButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createName() {
    return TextFormField(
      initialValue: product.titulo,
      decoration: InputDecoration(labelText: "Producto"),
      textCapitalization: TextCapitalization.sentences,
      onSaved: (newValue) => product.titulo = newValue,
      validator: (value) =>
          value.length < 3 ? "Ingrese el nombre del producto." : null,
    );
  }

  Widget _createPrice() {
    return TextFormField(
      initialValue: product.valor.toString(),
      decoration: InputDecoration(labelText: "Precio"),
      keyboardType: TextInputType.number,
      onSaved: (newValue) => product.valor = double.parse(newValue),
      validator: (value) =>
          utils.isNumeric(value) ? null : "Sólo se aceptan números.",
    );
  }

  Widget _createAvailable() {
    return SwitchListTile(
      value: product.disponible,
      title: Text("Disponible"),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState(() {
        product.disponible = value;
      }),
    );
  }

  Widget _createButton() {
    return ElevatedButton.icon(
      onPressed: _submit,
      icon: Icon(Icons.save),
      label: Text("Guardar"),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        primary: Colors.deepPurple,
      ),
    );
  }

  void _submit() {
    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    productsProvider.createProduct(product);

    print("OK...");
  }
}
