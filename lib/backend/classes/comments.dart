import 'package:cloud_firestore/cloud_firestore.dart';

class Comments {
  String? content;
  String? email;
  String? initiativeId;
  String? name;
  DateTime? timestamp;
  String? id;

  Comments(
      {this.content, this.email, this.initiativeId, this.name, this.timestamp});

  Comments.fromJson(Map<String, dynamic> json) {
    final Timestamp datetime = json['timestamp'];
    id = json['id'];
    content = json['content'];
    email = json['email'];
    initiativeId = json['initiativeId'];
    name = json['name'];
    timestamp = datetime.toDate();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    data['email'] = email;
    data['initiativeId'] = initiativeId;
    data['name'] = name;
    data['timestamp'] = timestamp.toString();
    return data;
  }
}
