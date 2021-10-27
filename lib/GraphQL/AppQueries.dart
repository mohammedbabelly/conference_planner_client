class AppQueries {
  static const allTracksQuery = r'''query ($showSessions: Boolean!){
  tracks{
    id
    name
    sessions@include(if: $showSessions){
      id
      title
      startTime
      endTime
      type
    }
  }
}''';
}
