import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testproject/utils/util_styles.dart';

import 'preference_helper.dart';

customStats(statImage, stats, statText) {
  return Column(
    children: [
      Container(
        width: 50, // Adjust the size as needed
        height: 50, // Adjust the size as needed
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue[50], // Set the background color
        ),
        child: Center(
          child: ClipOval(
            child: Icon(
              statImage,
              size: 30,
              color: Colors.blueAccent, // Set the icon color
            ),
          ),
        ),
      ),
      Text(
        "$stats +",
        style: CustomTextStyles.normal(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            fontColor: Colors.blue),
      ),
      Text(
        statText,
        style: CustomTextStyles.normal(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            fontColor: Colors.grey),
      )
    ],
  );
}



customConfirmation({String? question, String? answer}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              question.toString(),
              style: CustomTextStyles.normal(
                  fontSize: 16.0, fontColor: Colors.grey),
            ),
            Text(
              answer.toString(),
              style: CustomTextStyles.normal(
                  fontSize: 16.0,
                  fontColor: Colors.black,
                  fontWeight: FontWeight.w600),
            )
          ],
        )
      ],
    ),
  );
}
