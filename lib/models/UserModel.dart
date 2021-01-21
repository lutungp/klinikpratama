class UserModel {
  num id;
  String name;
  String jwt;

  UserModel({this.id, this.name, this.jwt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    jwt = json['jwt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['jwt'] = this.jwt;
    return data;
  }
}
