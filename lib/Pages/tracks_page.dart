import 'package:conference_planner_client/GraphQL/AppQueries.dart';
import 'package:conference_planner_client/Models/Track.dart';
import 'package:conference_planner_client/Pages/sessions_page.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class TracksPage extends StatelessWidget {
  final ValueNotifier<GraphQLClient> gClient;
  const TracksPage(this.gClient, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Tracks"), centerTitle: true),
      body: Query(
          options: QueryOptions(
            document: gql(AppQueries.allTracksQuery),
            variables: {"showSessions": true},
          ),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }

            if (result.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            List<Track>? tracks = TrackType.fromJson(result.data!).tracks;

            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: tracks!.length,
                itemBuilder: (BuildContext context, int index) {
                  Track track = tracks[index];
                  return InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => SessionsPage(
                                  gClient,
                                  track: track,
                                ))),
                    child: Card(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(track.name!, style: TextStyle(fontSize: 30)),
                        SizedBox(height: 20),
                        Text(
                          track.sessions!.length.toString() + " Sessions",
                          style: TextStyle(color: Colors.pink[300]),
                        ),
                      ],
                    )),
                  );
                });
          }),
    );
  }
}
