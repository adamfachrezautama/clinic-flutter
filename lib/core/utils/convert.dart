import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Convert {
  static String formatTimeWithoutSeconds(String timeWithSeconds){
    DateTime parsedTime = DateFormat("HH:mm:ss").parse(timeWithSeconds);
    return DateFormat("HH:mm").format(parsedTime);
  }

  static String formatTo24Hour(TimeOfDay time){
   final int hour = time.hour;
   final int minute = time.minute;
   final String formattedHour = hour.toString().padLeft(2, '0');
   final String formattedMinute = minute.toString().padLeft(2, '0');
   return "$formattedHour:$formattedMinute";
  }

  static String formatToReadableDate(String dateTimeString){
    DateTime parsedDate =
        DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateTimeString);
    return DateFormat("dd MM yyyy").format(parsedDate);
  }

  // Menambahkan metode untuk format waktu
  static String formatToReadableTime(String dateTimeString){
    DateTime parsedDate =
    DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateTimeString);
    return DateFormat("HH:mm").format(parsedDate);
  }
  static String formatToReadableTime2(String dateTimeString){
    DateTime parsedDate = DateFormat("HH:mm:ss").parse(dateTimeString);
    return DateFormat("HH:mm").format(parsedDate);
  }

  // Membersihkan semua karakter non-numeric dari string
  static String cleanCurrencyToNumber(String formattedText){
    return formattedText.replaceAll(RegExp(r'[^0-9]'), '');
  }

  static String extracTime(String dateTimeString){
    DateTime dateTime = DateTime.parse(dateTimeString);
    return DateFormat('HH:mm').format(dateTime);
  }

}