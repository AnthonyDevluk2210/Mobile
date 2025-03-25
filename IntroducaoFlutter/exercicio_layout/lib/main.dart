import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MyApp(), debugShowCheckedModeBanner: false));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Atividade Pratica")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  color: Colors.grey,
                  height: 100,
                  width: 100,
                ),
                  Image.asset("")
              ],
            ),
            Text("Nome: Leandro.",
            style: TextStyle(
              fontSize: 18,
              color: Colors.tealAccent,
              )),
            Text("Idade: 20",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: Colors.tealAccent,
            ),),
          ],
        ),
      ),
    );
  }
}
