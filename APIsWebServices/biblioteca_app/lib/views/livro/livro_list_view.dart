import 'package:biblioteca_app/models/livro_model.dart';
import 'package:flutter/material.dart';

class LivroListView extends StatefulWidget {
  const LivroListView({super.key});

  @override
  State<LivroListView> createState() => _LivroListViewState();
}

class _LivroListViewState extends State<LivroListView> {
  //atributos
  final _controller = null;
  List<LivroModel> _livros = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  _carregarDados() async{
    setState(() {
      _carregando = true;
    });
    try {
      _livros = await _controller.fetchAll();
    } catch (e) {
      //Tratar Erro      
    }
    setState(() {
      _carregando = false;
    });
  }
  //build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _carregando,
    )
  }
}
