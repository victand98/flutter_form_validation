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
  final scaffoldKey = GlobalKey<ScaffoldState>();

  ProductModel product = ProductModel();

  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    final ProductModel productData = ModalRoute.of(context).settings.arguments;

    if (productData != null) {
      product = productData;
    }

    return Scaffold(
      key: scaffoldKey,
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
      onPressed: _saving ? null : _submit,
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

    setState(() {
      _saving = true;
    });

    product.id == null
        ? productsProvider.createProduct(product)
        : productsProvider.updateProduct(product);

    showSnackbar("Registro Guardado");

    Navigator.pop(context);
  }

  void showSnackbar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(
        milliseconds: 1500,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
