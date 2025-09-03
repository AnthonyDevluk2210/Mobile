import 'package:biblioteca_app/controllers/livro_controller.dart';
import 'package:biblioteca_app/models/livro_model.dart';
import 'package:flutter/material.dart';

class LivroFormView extends StatefulWidget {
  final LivroModel? livro;

  const LivroFormView({super.key, this.livro});

  @override
  State<LivroFormView> createState() => _LivroFormViewState();
}

class _LivroFormViewState extends State<LivroFormView> {
  final _formKey = GlobalKey<FormState>();
  final _controller = LivroController();

  final _titulo = TextEditingController();
  final _autor = TextEditingController();
  bool _disponivel = true;

  @override
  void initState() {
    super.initState();
    if (widget.livro != null) {
      _titulo.text = widget.livro!.titulo;
      _autor.text = widget.livro!.autor;
      _disponivel = widget.livro!.disponivel;
    }
  }

  void _salvar() async {
    if (_formKey.currentState!.validate()) {
      final livroNovo = LivroModel(
        id: widget.livro?.id, // Usado para editar
        titulo: _titulo.text.trim(),
        autor: _autor.text.trim(),
        disponivel: _disponivel,
      );

      if (widget.livro == null) {
        await _controller.adicionarLivro(livroNovo);
      } else {
        await _controller.atualizarLivro(livroNovo);
      }

      Navigator.pop(context, true); // Retorna para a tela anterior
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.livro == null ? 'Adicionar Livro' : 'Editar Livro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titulo,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o título';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _autor,
                decoration: const InputDecoration(labelText: 'Autor'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o autor';
                  }
                  return null;
                },
              ),
              SwitchListTile(
                title: const Text('Disponível'),
                value: _disponivel,
                onChanged: (value) {
                  setState(() {
                    _disponivel = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvar,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
