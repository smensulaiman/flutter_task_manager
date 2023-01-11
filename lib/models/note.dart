class Note {
  late int _id;
  late String _title;
  late String _description = "";
  late String _date;
  late int _priority;

  Note(this._title, this._description, this._date, this._priority);

  Note.withId(
      this._id, this._title, this._description, this._date, this._priority);

  Note.fromMapToObject(Map<String, dynamic> map) {
    _id = map['id'];
    _title = map['title'];
    _description = map['description'];
    _date = map['date'];
    _priority = map['priority'];
  }

  int get priority => _priority;

  set priority(int value) {
    _priority = value;
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['priority'] = priority;
    map['date'] = date;
    return map;
  }
}
