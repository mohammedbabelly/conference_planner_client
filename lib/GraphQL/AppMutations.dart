class AppMutations {
  static const registerAttendee =
      r'''mutation($sessionId: Int!, $attendee: AttendeeInput!){
  registerAttendee(sessionId: $sessionId, attendee: $attendee){
    id
    name
    email
  }
}''';
}
