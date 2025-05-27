class DbHelper {
  static DataBase? _database; //obj para criar as conexões

  //transformar esse classe em singleton
  //não permite instanciar outro obj enquanto um obj estiver ativo
  static final DbHelper _instance = DbHelper._internal();

  //Construir o Singleton
  DbHelper._internal();
  factory DbHelper() {
    return _instance;
  }

  //conexões do Banco de Dados
  Future<Database> get database async {
    if (_database != null) {
      return _database!; // se o banco já estiiver fncionando ele retorna ele mesmo
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  Future<Database> _initDatabase() async {
    // pegar o local onde esta salvo o BD (path)
    final _dbPath = await getDatabasesPath();
    final path = join(_dbPath, "petshop.db"); //caminho para o banco de dados

    return await openDatabase(path); // cenas para o próximo cápitulo
  }
}
