import 'package:flutter/material.dart';

import 'package:flutter_form_validation/src/utils/utils.dart' as utils;

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();

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
              children: [_createName(), _createPrice(), _createButton()],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createName() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Producto"),
      textCapitalization: TextCapitalization.sentences,
      validator: (value) =>
          value.length < 3 ? "Ingrese el nombre del producto." : null,
    );
  }

  Widget _createPrice() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Precio"),
      keyboardType: TextInputType.number,
      validator: (value) =>
          utils.isNumeric(value) ? null : "Sólo se aceptan números.",
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

    print("OK...");
  }
}
