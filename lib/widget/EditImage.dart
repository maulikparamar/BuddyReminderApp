import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class EditImage extends StatefulWidget {
  final Function(String image,String imageText) updateData;
  
  const EditImage({super.key, required this.updateData});
  @override
  State<StatefulWidget> createState() => _EditImageWidgetState();
}


class _EditImageWidgetState extends State<EditImage>{

  String path = "";

  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          textDirection: TextDirection.ltr,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                child: Text(
                  "Image",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                )),

            Row(children: [
                 Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: ElevatedButton(
                    onPressed: () async {
                      String d = await imagePickerWidget(context);
                      if(d.isNotEmpty){
                        String imageText = await getImageTotext(d);
                        setState(() {
                          path = d;
                        });
                       widget.updateData(d,imageText);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(double.infinity, double.infinity),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape:
                            const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                        elevation: 0,
                        side: const BorderSide(color: Colors.black, width: 0.8)),
                    child: const Text("image"))
                    )         
            ],),
           path == "" ? const Text("No Image") : Image.file(File(path)),
          ]);
      }
}


Future<String> imagePickerWidget(BuildContext context) async {
  ImagePicker imagepicker = ImagePicker();
  XFile? galleryFile = await imagepicker.pickImage(source: ImageSource.gallery);
  // XFile? cameraFile =await imagepicker.pickImage(source: ImageSource.camera);
  if (galleryFile != null) {
    return galleryFile.path.toString();
  } else {
    return "";
  }
}


// Image to Text Generator
Future getImageTotext(final imagePath) async { 
  
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin); 
  final RecognizedText recognizedText = 
      await textRecognizer.processImage(InputImage.fromFilePath(imagePath)); 
  String text = recognizedText.text.toString(); 
  return text; 
} 