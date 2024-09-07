import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reminderapp/model/global.dart';
import 'package:reminderapp/model/noteModel.dart';
import 'package:reminderapp/provider/flutter_secure_storage.dart';


import 'package:flutter/material.dart'; 
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart'; 
import 'package:image_picker/image_picker.dart';

import '../widget/DateAndTime.dart';
import '../widget/EditImage.dart';

class NoteBook extends StatefulWidget {
  const NoteBook({super.key, required this.noteModel});
  final NoteModel noteModel;

  @override
  State<StatefulWidget> createState() => _NoteBookPageState();
}

class _NoteBookPageState extends State<NoteBook> {
  final TextEditingController notesTextEditing = TextEditingController();
  final TextEditingController noteNameTextEditing = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notesTextEditing.text = widget.noteModel.NoteDetails;
        noteNameTextEditing.text = widget.noteModel.Name;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    void updateData(String image,String imageText ){
        setState(() {
         widget.noteModel.NoteDetails = imageText;
          widget.noteModel.Image = image;
          notesTextEditing.text = imageText;
        });
    }

    void updateDateAndTime(DateTime? date,TimeOfDay? time){
    setState(() {
      if(date != null){
          widget.noteModel.Date = date;
      }
      if(time != null){
          widget.noteModel.Time = time;
      }

    });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.noteModel.Name),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DateAndTime(time:widget.noteModel.Time,dateTime: widget.noteModel.Date,updateDateAndTime: updateDateAndTime,),
            editNoteName(context,noteNameTextEditing),
            editNote(context, notesTextEditing),
            EditImage(updateData:updateData),
            Align(
              alignment: Alignment.topCenter,
              child: ElevatedButton(
                  onPressed: () {
                    widget.noteModel.Name = noteNameTextEditing.text;
                    widget.noteModel.NoteDetails = notesTextEditing.text;
                    setState(() {
                      noteBookList.add(widget.noteModel);
                    });
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(double.infinity, double.infinity),
                      backgroundColor: Colors.black87,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      elevation: 0,
                      side: const BorderSide(color: Colors.black, width: 0.8)),
                  child: const Text("Submit")),
            )
          ],
        ),
      ),
    );
  }
}

// Note: Edit Note Name
Widget editNoteName(BuildContext context, TextEditingController notesTextEditing) {
  return Column(
      textDirection: TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
            child: Text(
              "Note Name",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            )),
        Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Container(
                padding: const EdgeInsets.fromLTRB(13, 0, 10, 0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 0.8)),
                child: TextField(
                  controller: notesTextEditing,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  decoration: const InputDecoration(border: InputBorder.none),
                )))
      ]);
}

// Note: Edit Note
Widget editNote(BuildContext context, TextEditingController notesTextEditing) {
  return Column(
      textDirection: TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
            child: Text(
              "Note",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            )),
        Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Container(
                padding: const EdgeInsets.fromLTRB(13, 0, 10, 0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 0.8)),
                child: TextField(
                  controller: notesTextEditing,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  decoration: const InputDecoration(border: InputBorder.none),
                )))
      ]);
}
