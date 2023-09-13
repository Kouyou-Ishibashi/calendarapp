class Event {
  final int id;
  final String eventTitle;
  final String comment;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final bool allDayFlag;

  Event({
    required this.id,
    required this.eventTitle,
    required this.comment,
    required this.startDateTime,
    required this.endDateTime,
    required this.allDayFlag,
  });
}
