

import 'package:sa_pertshop/models/consulta_model.dart' show Consulta;
import 'package:sa_pertshop/services/db_helper.dart';

class ConsultaController {
  final _dbHelper = DbHelper();

  //métodos
  Future<int> createConsulta(Consulta consulta) async{
    return _dbHelper.insertConsulta(consulta);
  }

  Future<List<Consulta>> readConsultaByPet(int petId) async{
    return _dbHelper.getConsultaByPet(petId);
  }

  Future<int> deleteConsulta(int id) async{
    return _dbHelper.deleteConsulta(id);
  }
}