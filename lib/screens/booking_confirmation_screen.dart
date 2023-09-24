import 'package:flutter/material.dart';
import 'package:testproject/utils/util_routes.dart';
import 'package:testproject/utils/util_styles.dart';
import 'package:testproject/utils/util_widgets.dart';

import '../utils/preference_helper.dart';

class BookingConfirmationScreen extends StatefulWidget {
  const BookingConfirmationScreen({Key? key}) : super(key: key);

  @override
  State<BookingConfirmationScreen> createState() =>
      _BookingConfirmationScreenState();
}

class _BookingConfirmationScreenState extends State<BookingConfirmationScreen> {
  String? date;
  String? doctorName;
  String? time;

  Future getBookingDetails() async {
    date = await PreferencesHelper.getString("date");
    doctorName = await PreferencesHelper.getString("doctorName");
    time = await PreferencesHelper.getString("time");
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBookingDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        forceMaterialTransparency: true,
        backgroundColor: Colors.white,
        title: Text("Confirmation",
            style:
                CustomTextStyles.bold(fontColor: Colors.black, fontSize: 22.0)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.blueAccent,
              size: 100,
            ),
            Text(
              "Appointment Confirmed!",
              style: CustomTextStyles.normal(
                  fontSize: 20.0, fontWeight: FontWeight.w900),
            ),
            Text(
              "You have successfuly booked appointment with \n $doctorName",
              style: CustomTextStyles.normal(
                  fontSize: 16.0, fontWeight: FontWeight.w300),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  iconConfirmation(Icons.person, "Esther Howard"),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      iconConfirmation(Icons.calendar_today_outlined, date),
                      const SizedBox(
                        width: 50,
                      ),
                      iconConfirmation(Icons.timer, time)
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
                  width: 350,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20.0), // Adjust the value as needed
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, routeViewBooking);
                      /*Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ReviewBookingScreen(
                            doctorData: widget.doctorData,
                          )));     */
                    },
                    child: const Text("View Appointments"),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap:(){
                Navigator.pushNamed(context, routeDoctorList);
              },

              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  "Book Another",
                  style: CustomTextStyles.normal(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0,
                      fontColor: Colors.blueAccent),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
