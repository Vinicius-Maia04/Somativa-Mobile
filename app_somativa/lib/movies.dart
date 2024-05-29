import 'package:flutter/material.dart';

class Movies extends StatefulWidget {
  const Movies({super.key});

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {

  _getMovies()async{
    
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