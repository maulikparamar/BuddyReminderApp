import 'package:flutter/material.dart';
import 'package:reminderapp/model/noteModel.dart';

List<NoteModel> noteBookList = [NoteModel(), NoteModel()];

class MyGlobal {
  static String getDateToString(DateTime date){
      return "${date.day}/${date.month}/${date.year}";
  }
  static String getTimeToString(TimeOfDay time){
    return "${time.hour}:${time.minute}";
  }
}
