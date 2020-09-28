import 'package:flutter/material.dart';
import 'package:quizapp/DBhelper.dart';
import 'package:quizapp/questionDetail.dart';
import 'package:quizapp/questions.dart';

class QuestionList extends StatefulWidget {
  QuestionListState createState() => QuestionListState();
}

class QuestionListState extends State<QuestionList> {
  final DBHelper db = DBHelper();
  List<Questions> questions;

  void load() async {
    questions = List();
    questions = await db.getQuestions();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (questions == null) {
      load();
      return CircularProgressIndicator();
    } else
      return Scaffold(
        appBar: AppBar(
          title: Text("Questions"),
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => QuestionDetail(this, null)));
                })
          ],
        ),
        body: ListView.builder(
            itemCount: questions.length,
            itemBuilder: (BuildContext context, int index) {
              Questions item = questions[index];

              return GestureDetector(
                child: Container(
                    margin:
                        EdgeInsets.only(top: 5.0, bottom: 5, right: 1, left: 1),
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.pink[300],
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(item.getQuestion()),
                          IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                db.deleteQuestion(item.getID());
                                load();
                              })
                        ])),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => QuestionDetail(this, item)));
                },
              );
            }),
      );
  }
}
