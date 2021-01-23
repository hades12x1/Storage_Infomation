import 'dart:convert';

Password passwordFromJson(String str) {
  final jsonData = json.decode(str);
  return Password.fromJson(jsonData);
}

String clientToJson(Password data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Password {
  int id;
  String userName;
  String appName;
  String password;
  String url;
  String note;
  String icon;
  String color;

  Password({this.id, this.icon,this.color, this.userName, this.appName, this.password, this.url, this.note});

  Password.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appName = json['app_name'];
    password = json['password'];
    userName = json['user_name'];
    icon = json['icon'];
    url = json['url'] ?? '';
    note = json['note'] ?? '';
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['app_name'] = this.appName;
    data['password'] = this.password;
    data['user_name'] = this.userName;
    data['url'] = this.url ?? '';
    data['note'] = this.note ?? '';
    data['icon'] = this.icon;
    data['color'] = this.color;
    return data;
  }
}
