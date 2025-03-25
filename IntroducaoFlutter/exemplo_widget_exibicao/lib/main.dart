import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

//construir a Janela
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exemplo Widget de Exibição"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Olá, Flutter!!!", 
            style: TextStyle(
              fontSize: 20,
              color: Colors.blue)), //texto Simples
            Text("Flutter é Incrível!!!", 
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
                letterSpacing: 2
              ),), // Texto Personalizado
            Icon(Icons.star,size: 50, color: Colors.amber,),
            IconButton(
              onPressed: ()=> print("Icone Pressionado"), 
              icon: Icon(Icons.notifications, size: 50,)),
              //Imagens
              Image.network("https://tm.ibxk.com.br/2023/09/15/15154205365257.jpg?ims=750x",
              height: 300,
              width: 300,
              fit: BoxFit.cover,),
              //Imagem Local
              Image.asset("assets/img/image.png",
              height: 300,
              width: 300,
              fit: BoxFit.cover,)
          ],
        ),
      )
    );
  }
  
}