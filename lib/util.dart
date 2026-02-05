import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

String formatDate(DateTime date) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(date);
}

final uuid = Uuid();

String generateId() {
  return uuid.v1();
}


Future<DateTime?> presentDatePicker(BuildContext context, DateTime start, DateTime end) async {
  return await showDatePicker(
    context: context,
    firstDate: start,
    lastDate: end,
  );
}
