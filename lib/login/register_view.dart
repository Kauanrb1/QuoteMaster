import 'package:flutter/material.dart';
import 'package:quotemaster/models/user.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void _register() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      users.add(User(_email, _password));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Conta criada com sucesso!'), backgroundColor: Colors.green),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Criar Conta')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) => value!.isEmpty ? 'Por favor, insira seu email' : null,
                  onSaved: (value) => _email = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                  validator: (value) => value!.isEmpty ? 'Por favor, insira sua senha' : null,
                  onSaved: (value) => _password = value!,
                ),
                SizedBox(height: 20),
                ElevatedButton(onPressed: _register, child: Text('Criar Conta')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
