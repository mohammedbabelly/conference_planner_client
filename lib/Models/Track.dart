import 'dart:convert';

import 'Session.dart';

class TrackType {
  TrackType({
    this.tracks,
  });

  final List<Track>? tracks;

  factory TrackType.fromRawJson(String str) =>
      TrackType.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TrackType.fromJson(Map<String, dynamic> json) => TrackType(
        tracks: List<Track>.from(json["tracks"].map((x) => Track.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tracks": List<dynamic>.from(tracks!.map((x) => x.toJson())),
      };
}

class Track {
  Track({
    this.id,
    this.name,
    this.sessions,
  });

  final String? id;
  final String? name;
  final List<Session>? sessions;

  factory Track.fromRawJson(String str) => Track.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Track.fromJson(Map<String, dynamic> json) => Track(
        id: json["id"],
        name: json["name"],
        sessions: List<Session>.from(
            json["sessions"].map((x) => Session.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sessions": List<dynamic>.from(sessions!.map((x) => x.toJson())),
      };
}
