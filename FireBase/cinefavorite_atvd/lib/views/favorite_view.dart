import 'dart:io';

import 'package:cinefavorite_atvd/controllers/movie_firestore_controller.dart';
import 'package:cinefavorite_atvd/models/movie.dart';
import 'package:cinefavorite_atvd/views/search_movie_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  // Função para avaliar o filme
  void _avaliarFilme(BuildContext context, Movie movie) async {
    double novaNota = movie.rating;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: kDarkGray,
          title: Text("Avaliar Filme", style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Nota: ${novaNota.toStringAsFixed(1)}",
                style: TextStyle(color: Colors.white),
              ),
              Slider(
                value: novaNota,
                min: 0,
                max: 10,
                divisions: 20,
                activeColor: kDarkOrange,
                inactiveColor: kMediumGray,
                label: novaNota.toStringAsFixed(1),
                onChanged: (value) {
                  novaNota = value;
                  // Redesenha o dialog para atualizar a nota
                  (context as Element).markNeedsBuild();
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancelar", style: TextStyle(color: kMediumGray)),
            ),
            ElevatedButton(
              onPressed: () async {
                _movieController.updateMovieRating(movie.id, novaNota);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: kDarkOrange),
              child: Text("Salvar"),
            ),
          ],
        );
      },
    );
  }

  // Função para remover o filme
  void _removerFilme(BuildContext context, Movie movie) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: kDarkGray,
        title: Text("Remover Filme", style: TextStyle(color: Colors.white)),
        content: Text(
          "Deseja remover '${movie.title}' dos favoritos?",
          style: TextStyle(color: kMediumGray),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Cancelar", style: TextStyle(color: kMediumGray)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: kRed),
            child: Text("Remover"),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await _movieController.removeMovie(movie.id);
    }
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
            onPressed: FirebaseAuth.instance.signOut,
            color: kDarkOrange,
          ),
        ],
        elevation: 4,
      ),
      body: StreamBuilder<List<Movie>>(
        stream: _movieController.getFavoriteMovies(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Erro ao Carregar a Lista de Favoritos", style: TextStyle(color: Colors.white)),
            );
          }

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.isEmpty) {
            return Center(
              child: Text("Nenhum Filme Adicionado aos Favoritos", style: TextStyle(color: Colors.white)),
            );
          }

          final favoriteMovies = snapshot.data!;

          return GridView.builder(
            padding: EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.7,
            ),
            itemCount: favoriteMovies.length,
            itemBuilder: (context, index) {
              final movie = favoriteMovies[index];
              return Card(
                color: kDarkGray,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Image.file(
                        File(movie.posterPath),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Column(
                        children: [
                          Text(
                            movie.title,
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Nota: ${movie.rating.toStringAsFixed(1)}",
                            style: TextStyle(color: kMediumGray),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () => _avaliarFilme(context, movie),
                                icon: Icon(Icons.star, color: kDarkOrange),
                                tooltip: "Avaliar",
                              ),
                              IconButton(
                                onPressed: () => _removerFilme(context, movie),
                                icon: Icon(Icons.delete, color: kRed),
                                tooltip: "Remover",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchMovieView()),
        ),
        backgroundColor: kDarkOrange,
        child: Icon(Icons.search, color: Colors.white),
      ),
    );
  }
}
