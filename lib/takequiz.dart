import 'package:flutter/material.dart';
import 'package:quizapp/DBhelper.dart';
import 'package:quizapp/homescreen.dart';
import 'package:quizapp/player.dart';
import 'package:quizapp/questions.dart';

import 'main.dart';
import 'main.dart';

class TakeQuiz extends StatefulWidget {
  HomeScreenState homeScreenState;
  TakeQuiz(this.homeScreenState);

  TakeQuizState createState() => TakeQuizState();
}

class TakeQuizState extends State<TakeQuiz> {
  final DBHelper db = DBHelper();
  List<Questions> questions;
  String selected;
  int itemnav = 0;
  int lastnav = 0;
  int score = 0;
  final name = TextEditingController();

  void load() async {
    questions = List();
    questions = await db.getQuestions();
    lastnav = questions.length;
    setState(() {});
    if (questions.length == 0) {
        Navigator.pop(context);
    }
  }

  void next() {
    if (itemnav < lastnav) {
      if (questions[itemnav].getAns() == selected) {
        score += 1;
      } 
      if(itemnav == lastnav-1) {
        Player temp = Player(name.text, score);
        db.addPlayer(temp);
        widget.homeScreenState.load();
        Navigator.pop(context);
      }
      itemnav += 1;
      setState(() {
        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (questions == null) {
      load();
      return CircularProgressIndicator();
    } else
      return Scaffold(
        appBar: AppBar(
          title: Text("The Quiz"),
        ),
        body: Column(
          children: [
            TextField(
                controller: name,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: "Enter Name")),
            Text(questions[itemnav].getQuestion()),
            SizedBox(height: 30),
            ListTile(
              title: Text(questions[itemnav].getChoice1()),
              leading: Radio(
                value: questions[itemnav].getChoice1().toString(),
                groupValue: selected,
                onChanged: (String value) {
                  setState(() {
                    selected = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text(questions[itemnav].getChoice2()),
              leading: Radio(
                value: questions[itemnav].getChoice2().toString(),
                groupValue: selected,
                onChanged: (String value) {
                  setState(() {
                    selected = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text(questions[itemnav].getChoice3()),
              leading: Radio(
                value: questions[itemnav].getChoice3().toString(),
                groupValue: selected,
                onChanged: (String value) {
                  setState(() {
                    selected = value;
                  });
                },
              ),
            ),
            ListTile(
              title: Text(questions[itemnav].getChoice4()),
              leading: Radio(
                value: questions[itemnav].getChoice4().toString(),
                groupValue: selected,
                onChanged: (String value) {
                  setState(() {
                    selected = value;
                  });
                },
              ),
            ),
            RaisedButton(onPressed: () {
              next();
            }, child: Center(child: Text("Next")))
          ],
        ),
      );
  }
}
