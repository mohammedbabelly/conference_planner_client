import 'package:conference_planner_client/Models/Track.dart';
import 'package:conference_planner_client/Pages/session_details_page.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SessionsPage extends StatelessWidget {
  final ValueNotifier<GraphQLClient> gClient;
  final Track track;
  const SessionsPage(this.gClient, {required this.track, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(track.name! + " Sessions"),
      ),
      body: ListView.builder(
        itemCount: track.sessions!.length,
        itemBuilder: (BuildContext context, int index) {
          final session = track.sessions![index];
          session.trackName = track.name;
          return ListTile(
            title: Text(session.title!),
            subtitle: Text(session.startTime!),
            trailing: Icon(Icons.arrow_forward_ios_rounded, color: Colors.pink),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => SessionDetailsPage(
                          gClient,
                          session: session,
                        ))),
          );
        },
      ),
    );
  }
}
