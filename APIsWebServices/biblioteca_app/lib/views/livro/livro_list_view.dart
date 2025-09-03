import 'package:biblioteca_app/controllers/livro_controller.dart';
import 'package:biblioteca_app/models/livro_model.dart';
import 'package:biblioteca_app/views/livro/livro_form_view.dart';
import 'package:flutter/material.dart';

class LivroListView extends StatefulWidget {
  const LivroListView({super.key});

  @override
  State<LivroListView> createState() => _LivroListViewState();
}

class _LivroListViewState extends State<LivroListView> {
  final _controller = LivroController();
  List<LivroModel> _livros = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarDados();
  }

  Future<void> _carregarDados() async {
    setState(() => _carregando = true);
    try {
      final livros = await _controller.fetchAll();
      setState(() => _livros = livros);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar livros: $e')),
      );
    } finally {
      setState(() => _carregando = false);
    }
  }

  Future<void> _adicionarLivro() async {
    // Aqui aguardamos a tela de adicionar livro
    final resultado = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => const LivroFormView(),
      ),
    );

    // Se a tela de adicionar retornou 'true', recarrega os dados
    if (resultado == true) {
      await _carregarDados();
    }
  }

  Future<void> _deletarLivro(LivroModel livro) async {
    final confirmacao = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Excluir Livro'),
        content: Text('Deseja realmente excluir "${livro.titulo}"?'),
        actions: [
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.pop(context, false),
          ),
          ElevatedButton(
            child: const Text('Excluir'),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );

    if (confirmacao == true) {
      await _controller.removerLivro(livro.id!);
      await _carregarDados(); // Garante que lista será atualizada
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Livros'),
      ),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : _livros.isEmpty
              ? const Center(child: Text('Nenhum livro encontrado.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: _livros.length,
                  itemBuilder: (context, index) {
                    final livro = _livros[index];
                    return Card(
                      child: ListTile(
                        title: Text(livro.titulo),
                        subtitle: Text(livro.autor),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deletarLivro(livro),
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarLivro,
        child: const Icon(Icons.add),
      ),
    );
  }
}
