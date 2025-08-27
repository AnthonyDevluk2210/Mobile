//classe que vai auxiliar as conexões com com o DB
import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  // criar métodos de classe e não métodos de OBJ
  // permite uma maior segurança na solicitação de requisições http
  // static -> métodos e atributos de classe

  static const String _baseUrl = "http://10.109.197.26:3016";

  //métodos da Classe

  //GET -> Pegar a Lista de Recursos
  static Future<List<dynamic>> getList(String path) async {
    final res = await http.get(Uri.parse("$_baseUrl/$path"));
    //Verificar a aresposta
    if (res.statusCode == 200) return json.decode(res.body);
    //se não deu certo
    throw Exception("Falha ao Carregar Lista de $path");
  }

  //GET -> Pegar único Recurso
  static Future<Map<String, dynamic>> getOne(String path, String id) async {
    final res = await http.get(Uri.parse("$_baseUrl/$path/$id"));
    if (res.statusCode == 200) return json.decode(res.body);
    throw Exception("Falha ao Carregar Recurso de $path/$id");
  }

  //POST -> Adicionar Recursos no DB
  static Future<Map<String, dynamic>> post(
    String path,
    Map<String, dynamic> body,
  ) async {
    final res = await http.post(
      Uri.parse("$_baseUrl/$path"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(body),
    );
    if (res.statusCode == 201) return json.decode(res.body);
    throw Exception("Falha ao Adicionar Recurso em $path");
  }

  //PUT -> Altera Recursos do DB
  static Future<Map<String, dynamic>> put(
    String path,
    Map<String, dynamic> body,
    String id,
  ) async {
    final res = await http.put(
      Uri.parse("$_baseUrl/$path/$id"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(body),
    );
    if (res.statusCode == 200) return json.decode(res.body);
    throw Exception("Falha ao Alterar Recurso em $path");
  }

  //DELETE -> Remove o Recuros do DB
  static Future<void> delete(String path, String id) async {
    final res = await http.delete(Uri.parse("$_baseUrl/$path/$id"));
    if (res.statusCode != 200)
      throw Exception("Falha ao Deletar Recurso $path");
  }
}
