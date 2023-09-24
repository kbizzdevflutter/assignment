import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Utilities {
  static hideKeyboard(context) {
    return FocusScope.of(context).unfocus();
  }

  static Future<bool> isConnectedNetwork() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  static hideSnackbar(context) {
    return ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  static showError(context, {error}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              const Icon(
                Icons.error,
                color: Colors.red,
                size: 30,
              ),
              const SizedBox(
                width: 8,
              ),
              Flexible(
                  child: Text(
                    error,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  )),
            ],
          ),
        ),
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.white,
    ));
  }

  static showSuccess(context, {message}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 30,
              ),
              const SizedBox(
                width: 8,
              ),
              Flexible(
                  child: Text(
                    message,
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                  )),
            ],
          ),
        ),
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.white,
    ));
  }

  static dateFormatConv(date) {
    // var date = jobDetails.startdate;
    var splitDate = date.split(" ");
    var yearSpit = splitDate[1].split(",");
    var selMo = splitDate[0];
    var month = 1;
    switch (selMo) {
      case "Jan":
        month = 1;
        break;
      case "Feb":
        month = 2;
        break;
      case "Mar":
        month = 3;
        break;
      case "Apr":
        month = 4;
        break;
      case "May":
        month = 5;
        break;
      case "Jun":
        month = 6;
        break;
      case "Jul":
        month = 7;
        break;
      case "Aug":
        month = 8;
        break;
      case "Sep":
        month = 9;
        break;
      case "Oct":
        month = 10;
        break;
      case "Nov":
        month = 11;
        break;
      case "Dec":
        month = 12;
        break;
    }

    var con = DateTime(int.parse(yearSpit[1]), month, int.parse(yearSpit[0]));
    var formattedDate = DateFormat('MM/dd/yyyy').format(con);
    return formattedDate;
  }

  static showToast({message}) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black45,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
