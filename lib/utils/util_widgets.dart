import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testproject/utils/util_styles.dart';

class OvalAvailabilityDate extends StatefulWidget {
  final String date;
  final ValueChanged<String> onDateSelected;
  final bool isSelected;
  final List<String> timeSlots;

  OvalAvailabilityDate({
    required this.date,
    required this.onDateSelected,
    this.isSelected = false,
    required this.timeSlots,
  });

  @override
  State<OvalAvailabilityDate> createState() => _OvalAvailabilityDateState();
}

class _OvalAvailabilityDateState extends State<OvalAvailabilityDate> {
  @override
  Widget build(BuildContext context) {
    final parsedDate = DateTime.parse(widget.date);

    final formattedDate = DateFormat('d MMM').format(parsedDate);

    return GestureDetector(
      onTap: () {
        widget.onDateSelected(widget.date);
      },
      child: Container(
        width: 80,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
            bottom: Radius.circular(20),
          ),
          color: widget.isSelected ?  Colors.blueAccent : Colors.white,
          border: Border.all(
            color: Colors.blue,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              formattedDate,
              style: TextStyle(
                color: widget.isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OvalAvailabilityTime extends StatefulWidget {
  final String time;
  final ValueChanged<String> onTimeSelected;
  final bool isSelected;

  OvalAvailabilityTime({required this.time, required this.isSelected, required this.onTimeSelected});

  @override
  State<OvalAvailabilityTime> createState() => _OvalAvailabilityTimeState();
}

class _OvalAvailabilityTimeState extends State<OvalAvailabilityTime> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.onTimeSelected(widget.time);
      },
      child: Container(
        width: 80,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(0),
            bottom: Radius.circular(20),
          ),
          color:widget.isSelected ?  Colors.blueAccent : Colors.white,
          border: Border.all(
            color: Colors.blue,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            widget.time,
            style: TextStyle(
              color: widget.isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}


Widget iconConfirmation(icon, title){
  return Row(
    children: [
      Icon(icon, size:30, color: Colors.blueAccent,),
      Text(title.toString(), style: CustomTextStyles.normal(
          fontSize: 15.0, fontWeight: FontWeight.w900),)
    ],
  );
}