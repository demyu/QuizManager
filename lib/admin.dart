class Admin {
  
  String _name,_password;
  int _id;

  Admin(this._name, this._password);
  Admin.withID(this._id, this._name, this._password);
  Admin.fromDB(Map<String, dynamic> data) {
    this._id = data['id'];
    this._name = data['name'];
    this._password = data['password'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      'name': this._name,
      'password': this._password
    };
    if (_id != null) {
      data['id'] = this._id;
    }
    return data;
  }

  String getName(){
    return this._name;
  }

  String getPassword(){
    return this._password;
  }
}