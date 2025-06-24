import 'package:intl/intl.dart';

class DateTimeConverter {

  String convertISOToDesiredFormat(String isoDate) {
    // final inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'");
    // final outputFormat = DateFormat("yyyy-MM-dd");
    // final dateTime = inputFormat.parse(isoDate, true);

    DateTime originalDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(isoDate);
    String formattedDate = DateFormat("yyyy-MM-dd").format(originalDate);

    return formattedDate;
    // return outputFormat.format(dateTime);
  }

}