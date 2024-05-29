import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Movies extends StatefulWidget {
  const Movies({super.key});

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  Future<List<Post>> postsFuture = getPosts();

  // function to fetch data from api and return future list of posts
  static Future<List<Post>> getPosts() async {
    var url = Uri.parse('https://raw.githubusercontent.com/danielvieira95/DESM-2/master/filmes.json');
    final response = await http.get(url, headers: {"Content-Type": "application/json"});
    final List body = json.decode(response.body);
    return body.map((e) => Post.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Catálogo', style: TextStyle(color: Colors.white),)),
        backgroundColor: const Color.fromARGB(255, 179, 12, 0),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: FutureBuilder<List<Post>>(
          future: postsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(color: Color.fromARGB(255, 179, 12, 0),);
            } else if (snapshot.hasData) {
              final posts = snapshot.data!;
              return buildPosts(posts);
            } else {
              // if no data, show simple Text
              return const Text("Nenhum Filme Encontrado!");
            }
          },
        ),
      )
    );
  }
}

Widget buildPosts(List<Post> posts) {
  // ListView Builder to show data in a list
  return ListView.builder(
    itemCount: posts.length,
    itemBuilder: (context, index) {
      final post = posts[index];
      return Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        height: MediaQuery.of(context).size.height/5,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 31, 31, 31),
          border: Border.all(width: 5, color: Color.fromARGB(255, 50, 50, 50)),
          borderRadius: BorderRadius.circular(15)
        ),
        child: Row(
          children: [
            Expanded(flex: 3, child: Image.network(post.imagem!)),
            SizedBox(width: 10),
            Expanded(flex: 3, child: Container(
              child: ListView(
                children: [
                  Text(post.nome!, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
                  Padding(padding: EdgeInsets.all(5)),
                  Text('Lançamento: ${post.ano_de_lancamento!}',style: TextStyle(color: Colors.white, fontSize: 15),),
                  Text('Duração: ${post.duracao!}',style: TextStyle(color: Colors.white, fontSize: 15),),
                  Text('Nota: ${post.nota!} estrelas',style: TextStyle(color: Colors.white, fontSize: 15),)
                ],
              ),
            )),
          ],
        ),
      );
    },
  );
}

class Post {
  String? nome;
  String? imagem;
  String? duracao;
  String? ano_de_lancamento;
  String? nota;

  Post({this.nome, this.imagem, this.duracao, this.ano_de_lancamento, this.nota});

  Post.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    imagem = json['imagem'];
    duracao = json['duração'];
    ano_de_lancamento = json['ano de lançamento'];
    nota = json['nota'];
  }
}
