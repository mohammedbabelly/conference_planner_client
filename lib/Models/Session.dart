import 'dart:convert';

import 'package:intl/intl.dart';

class Session {
  Session(
      {this.id,
      this.title,
      this.description,
      this.startTime,
      this.endTime,
      this.type});

  final String? id;
  final String? title;
  final String? description;
  final String? startTime;
  final String? endTime;
  final String? type;
  late final String? trackName;

  factory Session.fromRawJson(String str) => Session.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        startTime: DateFormat('dd/MM/yyyy HH:mm')
            .format(DateTime.parse(json["startTime"]))
            .toString(),
        endTime: DateFormat('dd/MM/yyyy HH:mm')
            .format(DateTime.parse(json["endTime"]))
            .toString(),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "startTime": startTime,
        "endTime": endTime,
        "type": type,
      };
}
