class ScheduleDummyData {
  final String? date;
  final String? subject;
  final String? time;
  final String? roomNo;
  final String? section;
  final String? teacher;

  ScheduleDummyData(
    this.date,
    this.subject,
    this.time,
    this.roomNo,
    this.section,
    this.teacher,
  );
}

List<ScheduleDummyData> scheduleData = [
  ScheduleDummyData("Apr 06", "MAT", "9:00 am", "420", "21//12/22", "Ronaldo"),
  ScheduleDummyData("Apr 07", "ENG", "9:00 am", "420", "22/12/22", "Messi"),
];
