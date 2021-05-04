import 'package:flutter/material.dart';
import 'package:flutter_form_validation/src/blocs/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Página Principal"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Correo: ${bloc.email}"),
          Divider(),
          Text("Contraseña: ${bloc.password}"),
        ],
      ),
    );
  }
}
