// calsse controller para Usuários
import 'package:biblioteca_app/models/livro_model.dart';
import 'package:biblioteca_app/services/api_service.dart';

class LivroController {
  //GET Livros
  Future<List<LivroModel>> fetchAll() async {
    final list = await ApiService.getList("livros");
    return list.map<LivroModel>((e) => LivroModel.fromJson(e)).toList();
  }

  //GET Livro
  Future<LivroModel> fetchOne(String id) async {
    final livro = await ApiService.getOne("livros", id);
    return LivroModel.fromJson(livro);
  }

  //POST Livro
  Future<LivroModel> create(LivroModel u) async {
    final created = await ApiService.post("livros", u.toJson());
    return LivroModel.fromJson(created);
  }

  //PUT Livro
  Future<LivroModel> update(LivroModel u) async {
    final update = await ApiService.put("livros", u.toJson(), u.id!);
    return LivroModel.fromJson(update);
  }

  //DELETE Livro
  Future<void> delete(String id) async {
    await ApiService.delete("livros", id); //não tem retorno
  }
}
