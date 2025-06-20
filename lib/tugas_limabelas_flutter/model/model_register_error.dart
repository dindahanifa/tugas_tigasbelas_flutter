// To parse this JSON data, do
//
//     final registerError = registerErrorFromJson(jsonString);

import 'dart:convert';

RegisterError registerErrorFromJson(String str) => RegisterError.fromJson(json.decode(str));

String registerErrorToJson(RegisterError data) => json.encode(data.toJson());

class RegisterError {
    String? message;
    Errors? errors;

    RegisterError({
        this.message,
        this.errors,
    });

    factory RegisterError.fromJson(Map<String, dynamic> json) => RegisterError(
        message: json["message"],
        errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "errors": errors?.toJson(),
    };
}

class Errors {
    List<String>? name;
    List<String>? email;
    List<String>? password;

    Errors({
        this.name,
        this.email,
        this.password,
    });

    factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        name: json["name"] == null ? [] : List<String>.from(json["name"]!.map((x) => x)),
        email: json["email"] == null ? [] : List<String>.from(json["email"]!.map((x) => x)),
        password: json["password"] == null ? [] : List<String>.from(json["password"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "name": name == null ? [] : List<dynamic>.from(name!.map((x) => x)),
        "email": email == null ? [] : List<dynamic>.from(email!.map((x) => x)),
        "password": password == null ? [] : List<dynamic>.from(password!.map((x) => x)),
    };
}
