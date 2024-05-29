import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Movies extends StatefulWidget {
  const Movies({super.key});

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  String movies_url = 'https://raw.githubusercontent.com/danielvieira95/DESM-2/master/filmes.json';
  List data = [];
  _getMovies()async{
    http.Response response = await http.get(Uri.parse(movies_url));
    data = json.decode(response.body) as List;
    
    for(int i=0; i<data.length;){
      MovieInformation(BuildContext context){
        SizedBox(
          width: MediaQuery.of(context).size.width/1.9,
          height: MediaQuery.of(context).size.height/4,
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width/2,
                height: MediaQuery.of(context).size.height/1.1,
                child: Image.network(data[i]["imagem"]),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width/2,
                height: MediaQuery.of(context).size.height/1.1,
              )
            ],
          ),
        );
      }
      i++;
      return MovieInformation(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Catálogo', style: TextStyle(color: Colors.white),)),
        backgroundColor: const Color.fromARGB(255, 179, 12, 0),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
        ],
      ),
    );
  }
}