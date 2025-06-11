import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


Map<String, String> formatDateTime(String rawDateTime) {
  try {
    final dateTime = DateTime.parse(rawDateTime);
    final day = DateFormat('dd').format(dateTime);
    final suffix = getDaySuffix(int.parse(day));
    final monthYear = DateFormat('MMM, yyyy').format(dateTime);
    final time = DateFormat('HH:mm').format(dateTime);

    return {
      'date': '$day$suffix $monthYear',
      'time': time,
    };
  } catch (e) {
    return {
      'date': '',
      'time': '',
    };
  }
}

String getDMY(String inputDate) {
  if(inputDate == ''){
    return '' ;
  }
  DateTime date = DateFormat('yyyy-MM-dd').parse(inputDate);
  return DateFormat('d MMM yyyy').format(date);
}

String getDM(String inputDate) {
  if(inputDate == ''){
    return '' ;
  }
  DateTime date = DateFormat('yyyy-MM-dd').parse(inputDate);
  return DateFormat('d MMM').format(date);
}

String getDaySuffix(int day) {
  if (day >= 11 && day <= 13) return 'th';
  switch (day % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}

Future<String> getDateFromUser(BuildContext context) async{
  DateTime? pickedDate = await showDatePicker(
    context: context, 
    initialDate: DateTime.now(), 
    firstDate: DateTime(1900), 
    lastDate: DateTime(2050),
    currentDate: DateTime.now(),
  );

  if(pickedDate != null){
    // return DateFormat.yMd().format(pickedDate);
    // return DateFormat('d MMM').format(pickedDate);
    return DateFormat('yyyy-MM-dd').format(pickedDate);
  }else{
    return '' ;
  }
}
