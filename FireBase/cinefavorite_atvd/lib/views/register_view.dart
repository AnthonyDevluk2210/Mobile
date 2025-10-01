import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Paleta de Cores
const Color kBackgroundBlack = Color(0xFF121212);
const Color kDarkGray = Color(0xFF1E1E1E);
const Color kMediumGray = Color(0xFF3A3A3A);
const Color kRed = Color(0xFFD32F2F);
const Color kDarkOrange = Color(0xFFFF5722);

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _emailField = TextEditingController();
  final _senhaField = TextEditingController();
  final _confSenhaField = TextEditingController();
  final _authController = FirebaseAuth.instance;
  bool _senhaOculta = true;
  bool _confSenhaOculta = true;

  void _registrar() async {
    final email = _emailField.text.trim();
    final senha = _senhaField.text;
    final confSenha = _confSenhaField.text;

    if (email.isEmpty || senha.isEmpty || confSenha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Preencha todos os campos")),
      );
      return;
    }

    if (senha != confSenha) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("As senhas não coincidem")),
      );
      return;
    }

    try {
      await _authController.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      String mensagemErro;
      switch (e.code) {
        case 'email-already-in-use':
          mensagemErro = 'Este email já está em uso.';
          break;
        case 'invalid-email':
          mensagemErro = 'Email inválido.';
          break;
        case 'weak-password':
          mensagemErro = 'A senha é muito fraca.';
          break;
        default:
          mensagemErro = 'Erro: ${e.message}';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(mensagemErro)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundBlack,
      appBar: AppBar(
        title: Text("Registro"),
        backgroundColor: kDarkGray,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 50),
            TextField(
              controller: _emailField,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(color: kMediumGray),
                filled: true,
                fillColor: kDarkGray,
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _senhaField,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Senha",
                labelStyle: TextStyle(color: kMediumGray),
                filled: true,
                fillColor: kDarkGray,
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _senhaOculta ? Icons.visibility : Icons.visibility_off,
                    color: kMediumGray,
                  ),
                  onPressed: () {
                    setState(() {
                      _senhaOculta = !_senhaOculta;
                    });
                  },
                ),
              ),
              obscureText: _senhaOculta,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _confSenhaField,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Confirmar Senha",
                labelStyle: TextStyle(color: kMediumGray),
                filled: true,
                fillColor: kDarkGray,
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _confSenhaOculta ? Icons.visibility : Icons.visibility_off,
                    color: kMediumGray,
                  ),
                  onPressed: () {
                    setState(() {
                      _confSenhaOculta = !_confSenhaOculta;
                    });
                  },
                ),
              ),
              obscureText: _confSenhaOculta,
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _registrar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kDarkOrange,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  textStyle: TextStyle(fontSize: 16),
                ),
                child: Text("Registrar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
