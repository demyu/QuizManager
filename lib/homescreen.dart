import 'package:flutter/material.dart';
import 'package:quizapp/DBhelper.dart';
import 'package:quizapp/login.dart';
import 'package:quizapp/player.dart';
import 'package:quizapp/questions.dart';
import 'package:quizapp/takequiz.dart';

class HomeScreen extends StatefulWidget {
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final DBHelper db = DBHelper();
  List<Player> player;
  List<Questions> questions;

  void load() async {
    player = List();
    questions = List();
    player = await db.getPlayer();
    questions = await db.getQuestions();
    setState(() {});
  }

  void refresh() async {
    load();
  }

  @override
  Widget build(BuildContext context) {
    if (player == null) {
      load();
      return CircularProgressIndicator();
    } else
      return Scaffold(
        appBar: AppBar(
          title: Text("Quiz"),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: 300.00,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: ExactAssetImage('assets/logo/logo.jpg'),
                    fit: BoxFit.fitHeight,
                  ),
                )),
            Container(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount: player.length,
                    itemBuilder: (BuildContext contect, int index) {
                      final review = player[index];
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        color: Colors.red[300],
                        child: Row(children: [
                          Text(player[index].getName() + " "),
                          SizedBox(width: 50),
                          Text(player[index].getScore().toString() + "/" + questions.length.toString()),
                        ]),
                      );
                    })),
            Row(children: [
              RaisedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => TakeQuiz(this)));
                  },
                  child: Center(child: Text("Take Quiz"))),
              
              RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => Login()));
                  },
                  child: Center(child: Text("Login")))
            ])
          ],
        )),
      );
  }
}
