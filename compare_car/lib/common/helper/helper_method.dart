import 'package:cloud_firestore/cloud_firestore.dart';

String formatData(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  DateTime nowOnly = DateTime.now();
  DateTime dateOnly = DateTime(dateTime.year, dateTime.month, dateTime.day);
  String year = dateTime.year.toString();
  String month = dateTime.month.toString().padLeft(2, '0');
  String day = dateTime.day.toString().padLeft(2, '0');
  int daysDifference = nowOnly.difference(dateOnly).inDays;
  String formattedDate = "$day/$month/$year";

  return daysDifference > 30
      ? formattedDate
      : daysDifference == 0
          ? "Hôm nay"
          : daysDifference == 1
              ? "Hôm qua"
              : "$daysDifference ngày trước";
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return to.difference(from).inDays;
}
