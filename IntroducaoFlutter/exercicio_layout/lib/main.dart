// tela de perfil com flutter

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Perfil do Usuário"),
      actions: [
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () => print("Configurações Pressionado"),
        ),
        IconButton(
          onPressed: () => print("Sair Pressionado"), 
          icon: Icon(Icons.exit_to_app))
      ],
      backgroundColor: Colors.grey,
      
      ),
      // imagem do usuario e informações do perfil
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            // informações do perfil
            Container(
              width: double.infinity,
              color: Colors.grey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.network(
                      "https://ducktales.fandom.com/pt-br/wiki/Pato_Donald",
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text("Nome: Pato Donald", style: TextStyle(fontSize: 20)),
                  Text("dataNascimento: 12/06/1985", style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
            
            // 3 container para exibir informações
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 243, 33, 33),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text("Seguidores: 20", style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 145, 243, 33),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text("Postagens: 110", style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 243, 33, 33),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text("Amigos proximos: 10", style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ],
            ),

            //lista com icones de redes sociais
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              
              children: [
                IconButton(
                  onPressed: () => print("Facebook Pressionado"),
                  icon: Icon(Icons.facebook),
                  iconSize: 50,
                ),
                IconButton(
                  onPressed: () => print("Instagram Pressionado"),
                  icon: Icon(Icons.camera_alt),
                  iconSize: 50,
                ),
                IconButton(
                  onPressed: () => print("Twitter Pressionado"),
                  icon: Icon(Icons.alternate_email),
                  iconSize: 50,
                ),
              ],
            ),
          ],
        ),
      ) ,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Buscar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Adicionar",
          ),
        ],
      ),
    );
  }
}