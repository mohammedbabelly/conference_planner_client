import 'package:conference_planner_client/Pages/tracks_page.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  final HttpLink httpLink = HttpLink("https://localhost:5001/graphql");

  final ValueNotifier<GraphQLClient> gClient = ValueNotifier<GraphQLClient>(
    GraphQLClient(link: httpLink, cache: GraphQLCache()),
  );

  runApp(MyApp(gClient));
}

class MyApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> gClient;
  const MyApp(this.gClient, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: gClient,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData(brightness: Brightness.dark),
        theme: ThemeData(primaryColor: Colors.pink),
        title: "ConferencePlannerQL Client",
        home: TracksPage(gClient),
      ),
    );
  }
}
