// calsse controller para Usuários
import 'package:biblioteca_app/models/usuario_model.dart';
import 'package:biblioteca_app/services/api_service.dart';

class UsuarioController {
  //métodos
  //GET Usuários
  Future<List<UsuarioModel>> fetchAll() async {
    final list = await ApiService.getList("usuarios?_sort=nome");
    //retornar a lista de usuários
    return list.map<UsuarioModel>((e) => UsuarioModel.fromJson(e)).toList();
  }

  //GET Usuário
  Future<UsuarioModel> fetchOne(String id) async {
    final user = await ApiService.getOne("usuarios", id);
    return UsuarioModel.fromJson(user);
  }

  //POST Usuário
  Future<UsuarioModel> create(UsuarioModel u) async {
    final created = await ApiService.post("usuarios", u.toJson());
    return UsuarioModel.fromJson(created);
  }

  //PUT Usuário
  Future<UsuarioModel> update(UsuarioModel u) async {
    final update = await ApiService.put("usuarios", u.toJson(), u.id!);
    return UsuarioModel.fromJson(update);
  }

  //DELETE Usuário
  Future<void> delete(String id) async {
    await ApiService.delete("usuarios", id); //não tem retorno
  }
}
