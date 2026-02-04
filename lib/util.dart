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
