import 'package:flutter/cupertino.dart';

class Questions {
  
  String _question;
  String choice1, choice2, choice3, choice4, ans;
  int _id;

  Questions(this._question, this.choice1, this.choice2, this.choice3, this.choice4, this.ans);
  Questions.withID(this._id, this._question, this.choice1, this.choice2, this.choice3, this.choice4, this.ans);
  Questions.fromDB(Map<String, dynamic> data) {
    this._id = data['id'];
    this._question = data['question'];
    this.choice1 = data['choice1'];
    this.choice2 = data['choice2'];
    this.choice3 = data['choice3'];
    this.choice4 = data['choice4'];
    this.ans = data['ans'];
  }


  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      'question': this._question,
      'choice1': this.choice1,
      'choice2': this.choice2,
      'choice3' : this.choice3,
      'choice4' : this.choice4,
      'ans' : this.ans
    };
    if (_id != null) {
      data['id'] = this._id;
    }
    return data;
  }

  int getID(){
    return this._id;
  }

  String getQuestion(){
    return this._question;
  }
  String getChoice1(){
    return this.choice1;
  }
  String getChoice2(){
    return this.choice2;
  }

  String getChoice3(){
    return this.choice3;
  }

  String getChoice4(){
    return this.choice4;
  }

  String getAns(){
    return ans;
  }
}