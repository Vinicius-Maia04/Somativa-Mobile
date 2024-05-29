import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String users_url = 'http://192.168.15.123:3000/users';
  List data = [];
  TextEditingController _user = TextEditingController();
  TextEditingController _password = TextEditingController();
  _SignUp()async{

    showAlertDialog1(BuildContext context) { 
      AlertDialog alerta = AlertDialog(
        title: Text("Erro no Cadastro", style: TextStyle(color: Colors.white),),
        content: Text("Usuário Inválido ou já Cadastrado!", style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromARGB(255, 31, 31, 31),
        actions: [
          ElevatedButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text('Ok', style: TextStyle(color: Colors.white),),
          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(const Color.fromARGB(255, 179, 12, 0))),),
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alerta;
        },
      );
    }

    http.Response response = await http.get(Uri.parse(users_url));
    data = json.decode(response.body);
    bool userFound = false;

    Map<String,dynamic> message = {
      "name": _user.text,
      "password": _password.text
    };

    for(int i=0; i<data.length;){
      if(_user.text == data[i]["name"]){
        userFound = true;
        break;
      } else {
        i++;
      }
    }

    if (userFound == true || _user.text==''){
      showAlertDialog1(context);
    } else {
      http.post(Uri.parse(users_url),
      headers: <String,String> {
        'Content-type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(message));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Cadastro', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),)),
        backgroundColor: const Color.fromARGB(255, 179, 12, 0),
        foregroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Icon(Icons.person, size: 125, color: Colors.grey,)),
          SizedBox(
            width: MediaQuery.of(context).size.width/1.5,
            child: Column(
              children: [
                TextField(
                  controller: _user,
                  cursorColor: const Color.fromARGB(255, 179, 12, 0),
                  keyboardType: TextInputType.name,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(5),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: const Color.fromARGB(255, 179, 12, 0), width: 4)
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Login',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 20
                    ),
                    floatingLabelStyle: TextStyle(
                      color: const Color.fromARGB(255, 179, 12, 0),
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    )
                  ),
                ),
                Padding(padding: EdgeInsets.all(25)),
                TextField(
                  controller: _password,
                  cursorColor: const Color.fromARGB(255, 179, 12, 0),
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.name,
                  obscureText: true,
                  obscuringCharacter: '•',
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(5),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: const Color.fromARGB(255, 179, 12, 0), width: 4)
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Senha',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 20
                    ),
                    floatingLabelStyle: TextStyle(
                      color: const Color.fromARGB(255, 179, 12, 0),
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    )
                  ),
                ),
                Padding(padding: EdgeInsets.all(25)),
                SizedBox(
                  width: MediaQuery.of(context).size.width/1.5,
                  child: ElevatedButton(onPressed: (){
                    _SignUp();
                  }, 
                  child: Text('Cadastrar-se', style: TextStyle(color: Colors.white, fontSize: 20),), 
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(const Color.fromARGB(255, 179, 12, 0)),
                  ),),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}



