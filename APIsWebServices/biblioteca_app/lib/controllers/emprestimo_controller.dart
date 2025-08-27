
import 'package:biblioteca_app/models/emprestimo_model.dart';
import 'package:biblioteca_app/services/api_service.dart';

class EmprestimoController {
  //GET Emprestimos
  Future<List<EmprestimoModel>> fetchAll() async {
    final list = await ApiService.getList("emprestimo");
    return list.map<EmprestimoModel>((e) => EmprestimoModel.fromJson(e)).toList();
  }

  //GET Emprestimo
  Future<EmprestimoModel> fetchOne(String id) async {
    final emprestimo = await ApiService.getOne("emprestimo", id);
    return EmprestimoModel.fromJson(emprestimo);
  }

  //POST Usuário
  Future<EmprestimoModel> create(EmprestimoModel u) async {
    final created = await ApiService.post("emprestimo", u.toJson());
    return EmprestimoModel.fromJson(created);
  }

  //PUT Emprestimo
  Future<EmprestimoModel> update(EmprestimoModel u) async {
    final update = await ApiService.put("emprestimo", u.toJson(), u.id!);
    return EmprestimoModel.fromJson(update);
  }

  //DELETE Emprestimo
  Future<void> delete(String id) async {
    await ApiService.delete("emprestimo", id); //não tem retorno
  }
}
