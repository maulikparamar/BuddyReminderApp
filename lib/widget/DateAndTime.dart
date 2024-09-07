// Note: Date And Time Box
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DateAndTime extends StatefulWidget{

   final Function(DateTime? date,TimeOfDay? time) updateDateAndTime; 
   DateTime dateTime;
   TimeOfDay time;
   DateAndTime({super.key, required this.time,required this.dateTime,required this.updateDateAndTime});
  
  @override
  State<StatefulWidget> createState() => _DateAndTimeWidgetState();
}

class _DateAndTimeWidgetState extends State<DateAndTime> {

 @override
  Widget build(BuildContext context) {
        return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Expanded(
          child: Column(
        textDirection: TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
              child: Text(
                "Date",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              )),
          Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: ElevatedButton(
                onPressed: () async {
                  DateTime date = await datePickerWidget(context);
                 
                 setState(() {
                    widget.dateTime = date;
                 });
                 widget.updateDateAndTime(date,null);
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(double.infinity, double.infinity),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape:
                        const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    elevation: 0,
                    side: const BorderSide(color: Colors.black, width: 0.8)),
                child: Text(formatDate(widget.dateTime, [dd, '-', mm, '-', yyyy])),
              ))
        ],
      )),
      Expanded(
          child: Column(
        textDirection: TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text(
                "Time",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              )),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: ElevatedButton(
                onPressed: () async {
                  TimeOfDay tod = await timePickerWidget(context);
                  
                  setState(() {
                    widget.time = tod;
                  });
                 widget. updateDateAndTime(null,tod);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    fixedSize: const Size(double.infinity, double.infinity),
                    shape:
                        const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    elevation: 0,
                    side: const BorderSide(color: Colors.black, width: 0.8)),
                child: Text(widget.time.format(context)),
              ))
        ],
      ))
    ]);
  }
}


Future<DateTime> datePickerWidget(BuildContext context) async {
  // return CupertinoDatePicker(
  //     mode: CupertinoDatePickerMode.dateAndTime,
  //     initialDateTime: DateTime.now(),
  //     onDateTimeChanged: (DateTime newDateTime) {},
  //     minuteInterval: 1);

  DateTime? d = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 5));

  return d ?? DateTime.now();
  // DatePickerDialog(firstDate: DateTime.now(), lastDate: DateTime.now());
}

Future<TimeOfDay> timePickerWidget(BuildContext context) async {
  TimeOfDay? tod =
      await showTimePicker(context: context, initialTime: TimeOfDay.now());

  if (tod != null) {
    return tod;
  }
  return TimeOfDay.now();
}

