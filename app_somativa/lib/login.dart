import 'dart:convert';
import 'package:app_somativa/signup.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:app_somativa/movies.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _user = TextEditingController();
  TextEditingController _password = TextEditingController();
  String users_url = 'http://192.168.15.123:3000/users';
  List data = [];

  _verifyLogin()async{

    showAlertDialog2(BuildContext context) { 
      AlertDialog alerta = AlertDialog(
        title: Text("Erro no Login", style: TextStyle(color: Colors.white),),
        content: Text("Usuário ou Senha Incorretos!", style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromARGB(255, 31, 31, 31),
        actions: [
          ElevatedButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text('Ok', style: TextStyle(color: Colors.white),),
          style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 179, 12, 0))),),
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
    data = json.decode(response.body) as List;
    bool userFound = false;

    for(int i=0; i<data.length;){
      if(_user.text == data[i]["name"] && _password.text == data[i]["password"]){
        userFound = true;
        break;
      } else {
        i++;
      }
    }

    if (userFound == true){
      Navigator.push(context, MaterialPageRoute(builder: (context) => Movies()));
      userFound = false;
    } else {
      showAlertDialog2(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Login', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),)),
        backgroundColor: const Color.fromARGB(255, 179, 12, 0),
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
                    _verifyLogin();
                  }, 
                  child: Text('Entrar', style: TextStyle(color: Colors.white, fontSize: 20),), 
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(const Color.fromARGB(255, 179, 12, 0)),
                  ),),
                ),
                Padding(padding: EdgeInsets.all(5)),
                RichText(
                  text: TextSpan(
                    text: 'Não possui uma conta? ',
                    style: TextStyle(),
                    children: <TextSpan>[
                    TextSpan(
                    text: 'Cadastre-se',
                    style: TextStyle(color: Colors.blueAccent, decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()
                    ..onTap = () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()))
                  ),
                  ],
                  ),
                ),
                Text('agora mesmo', style: TextStyle(color: Colors.white),)
              ],
            ),
          )
        ],
      ),
    );
  }
}
