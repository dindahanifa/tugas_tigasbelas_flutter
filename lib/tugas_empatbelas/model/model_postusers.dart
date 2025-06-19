// To parse this JSON data, do
//
//     final postUser = postUserFromJson(jsonString);

import 'dart:convert';

PostUser postUserFromJson(String str) => PostUser.fromJson(json.decode(str));

String postUserToJson(PostUser data) => json.encode(data.toJson());

class PostUser {
    int? userId;
    int? id;
    String? title;
    String? body;

    PostUser({
        this.userId,
        this.id,
        this.title,
        this.body,
    });

    factory PostUser.fromJson(Map<String, dynamic> json) => PostUser(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
    };
}
