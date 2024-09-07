import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reminderapp/model/global.dart';
import 'package:reminderapp/model/noteModel.dart';

import '../provider/flutter_secure_storage.dart';
import 'note_book.dart';

class NoteBookList extends StatefulWidget {
  const NoteBookList({super.key});

  @override
  State<StatefulWidget> createState() => _NoteBookListPageState();
}

class _NoteBookListPageState extends State<NoteBookList> {
   SecureStorage storage = SecureStorage();
  List<NoteModel> data = List.empty();

  void reload(){
    data = noteBookList;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Container(
        child: ElevatedButton(
            onPressed: ()async  {
              await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NoteBook(noteModel: NoteModel())),
              );

              setState(() {
                
              });
            },
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                padding: const EdgeInsets.fromLTRB(4, 20, 4, 20)),
            child: const Text(
              "+",
              style: TextStyle(fontSize: 23),
            )),
      ),
      body: ListView.builder(
        itemCount: noteBookList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap:  () async {
               final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          NoteBook(noteModel: noteBookList[index])),
                );

                // update UI
              if(result != null){
                  setState(() {
                    int i = noteBookList
                        .indexWhere((element) => element.Id == result.Id);
                    if (i == -1) {
                      noteBookList.add(result);
                    } else {
                      noteBookList[i] = result;
                    }
                    storage.writeSecureData(
                        "NoteBookList", noteBookList.toString());
                  });
              }
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        NoteBookItem(noteModel: noteBookList[index]),
                  ),
                  Divider(
                    color: Colors.grey.shade200,
                    thickness: 5,
                  )
                ],
              ));
        },
      ),
    );
  }
}

class NoteBookItem extends StatefulWidget {
  const NoteBookItem({super.key, required this.noteModel});
  final NoteModel noteModel;
  @override
  State<StatefulWidget> createState() => _NoteBookItemPageState();
}

class _NoteBookItemPageState extends State<NoteBookItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text("Note Name : " + widget.noteModel.Name),
          Container(child:widget.noteModel.Image == "" ? Text("No Image") : Image.file(File(widget.noteModel.Image),filterQuality: FilterQuality.low,fit: BoxFit.cover,),width: 60,height: 50)
        ]),
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
        ),
        Row(
          children: [Text("Notes : ${widget.noteModel.NoteDetails}",maxLines: 2,overflow: TextOverflow.ellipsis,)],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text("Date : " + MyGlobal.getDateToString(widget.noteModel.Date)),
          Text("Time : " + MyGlobal.getTimeToString(widget.noteModel.Time))
        ])
      ],
    );
  }
}
