import 'package:intl/intl.dart';

class FormatDate {
  
  String formatDate(DateTime data) {
    return DateFormat('dd/MM/yyyy').format(data);
  }

}