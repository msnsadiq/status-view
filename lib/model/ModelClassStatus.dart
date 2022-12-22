/// id : 3
/// title : "This is my first story"
/// read_status : false
/// image : "https://cdn.pixabay.com/photo/2017/11/12/09/05/black-2941843_1280.jpg"
/// profile : {"id":69,"name":"Jon Snow","image":"https://i.insider.com/57b4cabb04732f18008b4e47?width=1300&format=jpeg&auto=webp"}

class ModelClassStatus {
  ModelClassStatus({
    int? id,
    String? title,
    bool? readStatus,
    String? image,
    Profile? profile,
  }) {
    _id = id;
    _title = title;
    _readStatus = readStatus;
    _image = image;
    _profile = profile;
  }
  static List<ModelClassStatus> listFromJson(List<dynamic> json) {
    return json == null
        ? []
        : json.map((value) => ModelClassStatus.fromJson(value)).toList();
  }

  ModelClassStatus.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _readStatus = json['read_status'];
    _image = json['image'];
    _profile =
        json['profile'] != null ? Profile.fromJson(json['profile']) : null;
  }
  int? _id;
  String? _title;
  bool? _readStatus;
  String? _image;
  Profile? _profile;

  int? get id => _id;
  String? get title => _title;
  bool? get readStatus => _readStatus;
  String? get image => _image;
  Profile? get profile => _profile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['read_status'] = _readStatus;
    map['image'] = _image;
    if (_profile != null) {
      map['profile'] = _profile?.toJson();
    }
    return map;
  }
}

/// id : 69
/// name : "Jon Snow"
/// image : "https://i.insider.com/57b4cabb04732f18008b4e47?width=1300&format=jpeg&auto=webp"

class Profile {
  Profile({
    int? id,
    String? name,
    String? image,
  }) {
    _id = id;
    _name = name;
    _image = image;
  }

  Profile.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
  }
  int? _id;
  String? _name;
  String? _image;

  int? get id => _id;
  String? get name => _name;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    return map;
  }

  static List<ModelClassStatus> listFromJson(List<dynamic> json) {
    return json == null
        ? []
        : json.map((value) => ModelClassStatus.fromJson(value)).toList();
  }
}
