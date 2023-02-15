import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String converDate(Timestamp timestamp) {
  DateTime date = timestamp.toDate();
  String format = DateFormat("dd/MM/yyyy").format(date);
  return format;
}
