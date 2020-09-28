class Player {
  
  String _name;
  int _id, _score;

  Player(this._name, this._score);
  Player.withID(this._id, this._name, this._score);
  Player.fromDB(Map<String, dynamic> data) {
    this._id = data['id'];
    this._name = data['name'];
    this._score = data['score'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      'name': this._name,
      'score': this._score
    };
    if (_id != null) {
      data['id'] = this._id;
    }
    return data;
  }

  String getName(){
    return this._name;
  }

  int getId(){
    return this._id;
  }

  int getScore(){
    return this._score;
  }
}