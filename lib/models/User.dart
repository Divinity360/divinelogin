class User {

  int id;
  String _imei;
  String _firstName;
  String _lastName;
  String _email;
  String _dob;
  String _passportPath;
  String _picturePath;
  String _deviceName;
  String _longitude;
  String _latitude;

  User(this._imei, this._firstName, this._lastName, this._email, this._dob, this._passportPath, this._picturePath, this._deviceName, this._latitude, this._longitude);

  User.map(dynamic obj) {
    this._firstName = obj["firstname"];
    this._lastName = obj["lastname"];
    this._email = obj["email"];
    this._imei = obj["imei"];
    this._passportPath = obj["passportpath"];
    this._picturePath = obj["picturepath"];
    this._deviceName = obj["devicename"];
    this._longitude = obj["longitude"];
    this._latitude = obj["latitude"];
    this._dob = obj["dob"];
  }

  @override
  String toString() {
    return 'User{id: $id, _imei: $_imei, _firstName: $_firstName, _lastName: $_lastName, _email: $_email, _dob: $_dob, _passportPath: $_passportPath, _picturePath: $_picturePath, _deviceName: $_deviceName, _longitude: $_longitude, _latitude: $_latitude}';
  }

  String get firstName => _firstName;

  String get imei => _imei;

  String get lastName => _lastName;

  String get dob => _dob;

  String get email => _email;

  String get latitude => _latitude;

  String get longitude => _longitude;

  String get deviceName => _deviceName;

  String get picturePath => _picturePath;

  String get passportPath => _passportPath;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map["firstname"] = _firstName;
    map["lastname"] = _lastName;
    map["email"] = _email;
    map["imei"] = _imei;
    map["passportpath"] = _passportPath;
    map["picturepath"] = _picturePath;
    map["devicename"] = _deviceName;
    map["longitude"] = _longitude;
    map["latitude"] = _latitude;
    map["dob"] = _dob;

    return map;
  }

  void setUserId(int id) {
    this.id = id;
  }

}