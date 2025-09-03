class LivroModel {
  //atributos
  final String? id;
  final String titulo;
  final String autor;
  final bool disponivel;

//cosntrutor
  LivroModel({
    this.id,
    required this.titulo,
    required this.autor,
    required this.disponivel,
  });

  factory LivroModel.fromJson(Map<String, dynamic> json) => LivroModel(
    id: json["id"].toString(),
    titulo: json["titulo"].toString(),
    autor: json["autor"].toString(),
    disponivel: json["disponivel"] == true ? true : false,
  );

  //toJson OBJ => Map
  Map<String, dynamic> toJson() => {
    "id": id,
    "titulo": titulo,
    "autor": autor,
    "disponivel": disponivel,
  };
}
