import 'package:flutter/material.dart';
import 'package:quizapp/DBhelper.dart';
import 'package:quizapp/questions.dart';
import 'package:quizapp/questionslist.dart';

class QuestionDetail extends StatefulWidget {
  QuestionListState questionListState;
  Questions question;
  QuestionDetail(this.questionListState, this.question);

  QuestionDetailState createState() => QuestionDetailState();
}

class QuestionDetailState extends State<QuestionDetail> {
  final DBHelper db = DBHelper();
  final question = TextEditingController();
  final choice1 = TextEditingController();
  final choice2 = TextEditingController();
  final choice3 = TextEditingController();
  final choice4 = TextEditingController();
  final ans = TextEditingController();

  void save() {
    Questions temp = Questions(question.text, choice1.text, choice2.text,
        choice3.text, choice4.text, ans.text);
    db.addQuestion(temp);
    widget.questionListState.load();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Quiz Question"),
          actions: [
            IconButton(
                icon: Icon(Icons.save),
                onPressed: widget.question != null
                    ? null
                    : () {
                        save();
                      })
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            TextField(
              enabled: widget.question == null ? true : false,
              controller: question,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.question == null
                      ? "Enter question"
                      : widget.question.getQuestion()),
            ),
            TextField(
              enabled: widget.question == null ? true : false,
              controller: choice1,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.question == null
                      ? "Enter choice"
                      : widget.question.getChoice1()),
            ),
            TextField(
              enabled: widget.question == null ? true : false,
              controller: choice2,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.question == null
                      ? "Enter choice"
                      : widget.question.getChoice2()),
            ),
            TextField(
              enabled: widget.question == null ? true : false,
              controller: choice3,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.question == null
                      ? "Enter choice"
                      : widget.question.getChoice3()),
            ),
            TextField(
              enabled: widget.question == null ? true : false,
              controller: choice4,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.question == null
                      ? "Enter choice"
                      : widget.question.getChoice4()),
            ),
            TextField(
              enabled: widget.question == null ? true : false,
              controller: ans,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.question == null
                      ? "Enter answer"
                      : widget.question.getAns()),
            ),
          ]),
        ));
  }
}
