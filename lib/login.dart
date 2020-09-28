import 'package:flutter/material.dart';
import 'package:quizapp/DBhelper.dart';
import 'package:quizapp/admin.dart';
import 'package:quizapp/homescreen.dart';
import 'package:quizapp/questionslist.dart';

class Login extends StatefulWidget {
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {

  final name = TextEditingController();
  final password = TextEditingController();
  final snackBar = SnackBar(content: Text('Invalid Credentials'));
  List<Admin> admin;
  DBHelper db = DBHelper();

  void load() async{
    admin = List();
    admin = await db.getAdmin();
    setState(() {
      
    });
  }

  bool verify(){
    String dbname = admin[0].getName();
    String dbpass = admin[0].getPassword();
    if(dbname == name.text && dbpass == password.text){
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    if(admin == null){
      load();
      return CircularProgressIndicator();
    }else
    return Scaffold(
      appBar: AppBar(title: Text("Login"),
      ),
      body: Column(
        children: [
          TextField(
            controller: name,
             decoration: InputDecoration(
                border: InputBorder.none, hintText: 'Enter UserName'),
          ),
          SizedBox(height: 20,),
          TextField(
            controller: password,
             decoration: InputDecoration(
                border: InputBorder.none, hintText: 'Enter Password'),
          ),
          SizedBox(height: 20,),

           RaisedButton(
              onPressed: () {
                verify() ? Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => QuestionList(
                            ))):
                    Scaffold.of(context).showSnackBar(snackBar);
                    },
              child: Center(child: Text("Login")))
        ]
      ),
    );
  }
}