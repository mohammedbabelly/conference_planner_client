import 'package:conference_planner_client/GraphQL/AppMutations.dart';
import 'package:conference_planner_client/Models/Session.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SessionDetailsPage extends StatelessWidget {
  final ValueNotifier<GraphQLClient> gClient;
  final Session session;

  const SessionDetailsPage(this.gClient, {required this.session, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Session Details")),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTile("Title", session.title),
            _buildTile("Description", session.description),
            _buildTile("Track Name", session.trackName),
            _buildTile("Attendance Type", session.type),
            _buildTile("Start Time", session.startTime),
            _buildTile("End Time", session.endTime),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _showBottomSheet(session.id!, context),
          backgroundColor: Colors.pink,
          label: Text("Register", style: TextStyle(color: Colors.white))),
    );
  }

  Widget _buildTile(String label, String? details) {
    return details == null
        ? Container()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              children: [
                CircleAvatar(backgroundColor: Colors.pink, radius: 5),
                SizedBox(width: 10),
                Text(
                  label + ": ",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink),
                ),
                SizedBox(width: 5),
                Text(
                  details,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          );
  }

  Future<void> _showBottomSheet(String sessionId, BuildContext context) async {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();

    await showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        builder: (BuildContext context) {
          return DraggableScrollableSheet(
              initialChildSize: 0.4,
              maxChildSize: 0.4,
              minChildSize: 0.4,
              expand: true,
              builder: (context, scrollController) {
                return Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildTextField(nameController, 'Full Name'),
                        _buildTextField(emailController, 'Email'),
                        SizedBox(height: 20),
                        Mutation(
                          options: MutationOptions(
                              document: gql(AppMutations.registerAttendee),
                              onCompleted: (dynamic resultData) {
                                print(resultData);
                                _showSnackBar(
                                    context,
                                    "Thanks for registering, we will contact you soon",
                                    true);
                                Navigator.pop(context, true);
                              },
                              onError: (e) {
                                _showSnackBar(context, e.toString(), false);
                              }),
                          builder: (
                            RunMutation? runMutation,
                            QueryResult? result,
                          ) {
                            return TextButton.icon(
                              onPressed: () {
                                if (nameController.text.isEmpty ||
                                    emailController.text.isEmpty)
                                  _showSnackBar(
                                      context, "Fill the fields", false);
                                else
                                  runMutation!({
                                    "sessionId": sessionId,
                                    "attendee": {
                                      "name": nameController.text,
                                      "email": emailController.text
                                    }
                                  });
                              },
                              icon: Icon(Icons.check, color: Colors.pink),
                              label: Text("Register",
                                  style: TextStyle(color: Colors.pink)),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                );
              });
        });
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
  ) =>
      Padding(
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: TextField(
          controller: controller,
          cursorColor: Colors.white60,
          decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.pink),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.pink)),
              labelText: label,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
              suffixIcon: Icon(Icons.add, color: Colors.black)),
        ),
      );

  void _showSnackBar(BuildContext context, String theMessage, bool succsess) {
    final snackBar = SnackBar(
        content: ListTile(
            title: Text(theMessage),
            leading: succsess
                ? Icon(Icons.check, color: Colors.green)
                : Icon(Icons.close, color: Colors.red)),
        backgroundColor: Color(0xff222222));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
