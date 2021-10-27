import 'dart:convert';

class Session {
  Session({
    this.id,
    this.title,
    this.startTime,
    this.endTime,
    this.type,
  });

  final String? id;
  final String? title;
  final DateTime? startTime;
  final DateTime? endTime;
  final String? type;

  factory Session.fromRawJson(String str) => Session.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        id: json["id"],
        title: json["title"],
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "startTime": startTime!.toIso8601String(),
        "endTime": endTime!.toIso8601String(),
        "type": type,
      };
}
