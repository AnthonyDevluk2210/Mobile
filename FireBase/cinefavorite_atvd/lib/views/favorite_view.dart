import 'package:cinefavorite_atvd/controllers/movie_firestore_controller.dart';
import 'package:cinefavorite_atvd/models/movie.dart';
import 'package:flutter/material.dart';

// Paleta de cores personalizada
const Color kBackgroundBlack = Color(0xFF121212);
const Color kDarkGray = Color(0xFF1E1E1E);
const Color kMediumGray = Color(0xFFB0B0B0);
const Color kRed = Color(0xFFE50914);
const Color kDarkOrange = Color(0xFFFF6F00);

class FavoriteView extends StatelessWidget {
  final _movieController = MovieFirestoreController();
  FavoriteView({super.key});

  void _logout(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundBlack,
      appBar: AppBar(
        backgroundColor: kDarkGray,
        title: Text(
          'Cinefavorite',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: kRed,
            letterSpacing: 1.2,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => _logout(context),
            color: kDarkOrange,
          ),
        ],
        elevation: 4,
      ),
     body: StreamBuilder<List<Movie>>(
        stream: _movieController.getFavoriteMovies(), 
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          if(!snapshot.hasData || snapshot.data!.isEmpty){
            return Center(child: Text("Sua Galeria Esta Vazia"),);
          }
          final movies = snapshot.data!; //monto a lista de filmes
          return GridView.builder(
            padding: EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 8), 
            itemCount: movies.length,
            itemBuilder: (context, index){
              final movie = movies[index];
              return Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    //criar o cartão na proxima aula
                  ],
                ),
              );
            });
        }),
    );
  }
}
