// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

ErrorsModel errorsFromJson(String str) => ErrorsModel.fromJson(json.decode(str));

String errorsToJson(ErrorsModel data) => json.encode(data.toJson());

class ErrorsModel {
    ErrorsModel({
      required  this.errors,
    });

    final List<Error> errors;

    ErrorsModel copyWith({
        List<Error>? errors,
    }) => 
        ErrorsModel(
            errors: errors ?? this.errors,
        );

    factory ErrorsModel.fromJson(Map<String, dynamic> json) => ErrorsModel(
        errors: List<Error>.from(json["errors"].map((x) => Error.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "errors": List<dynamic>.from(errors.map((x) => x.toJson())),
    };
}

class Error {
    Error({
       required this.msg,
       required this.param,
       required this.location,
    });

    final String msg;
    final String param;
    final String location;

    Error copyWith({
        int? value,
        String? msg,
        String? param,
        String? location,
    }) => 
        Error(
            msg: msg ?? this.msg,
            param: param ?? this.param,
            location: location ?? this.location,
        );

    factory Error.fromJson(Map<String, dynamic> json) => Error(
        msg: json["msg"],
        param: json["param"],
        location: json["location"],
    );

    Map<String, dynamic> toJson() => {
        "msg": msg,
        "param": param,
        "location": location,
    };
}
