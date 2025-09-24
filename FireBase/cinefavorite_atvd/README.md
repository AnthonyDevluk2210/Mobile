# CineFavorite - Formativa 
Construindo um aplicativo do Zero - O CineFavorite permitirá criar uma conta e bsucar filmes em uma api e montar uma galeria pessoal de filmes favoritos, com capas e notas.

## Objetivos
- Integrar o Aplicativo a uma API 
- Criar uma conta pessoal no FireBase
- Armazenar informações para cada usuários das preferências solicitadas
- Consultar informações de Filmes (Capas, Título)

## Levantamentos de Requisitos

- Funcionais

- Não Funcionais

## Diagramas

1. ### Diagrama de Classe
    diagrama que demonstra as entidades da aplicação 

   - usuário (user) : Classe criada pelo FirBase
        - email
        - senha
        - id 
        - create()
        - login()
        - logout()

   - Filme (Movie) : Classe modelada pelo dev
    - number id:
    - string Titulo:
    - string PosterPath
    - boolean Favorito
    - double Nota
    - adicionar()
    - update()
    - remover()
    - listarFavoritos()

```mermaid

classDiagram
    class User{
        +String uid
        +String email
        +String password
        +CreateUser()
        +login()
        +logout()
    }
    clas Movie{
        +String id
        +String title
        +String posterPath
        +Boolean Favorite
        +double Rating
        +addFavorite()
        +removeFavorite()
        +updateRating()
        +read()
    }

    User "1"--"1+" Movie : "selecionar"


## Prototipagem 

## Codificação