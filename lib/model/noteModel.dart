import 'package:flutter/material.dart';

class NoteModel {
  String Id = DateTime.now().microsecondsSinceEpoch.toString();
  DateTime Date = DateTime.now();
  TimeOfDay Time = TimeOfDay.now();
  String Name = "Maulik";
  String NoteDetails = "Maulik test";
  String Image = "";
}
