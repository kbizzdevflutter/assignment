import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testproject/screens/booking_confirmation_screen.dart';
import 'package:testproject/screens/doctor_details_screen.dart';
import 'package:testproject/screens/doctor_list_Screen.dart';
import 'package:testproject/screens/rview_booking_screen.dart';
import 'package:testproject/screens/select_package_screen.dart';
import 'package:testproject/screens/view_bookings_screen.dart';
import 'package:testproject/utils/util_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: MaterialApp(
            title: 'Shiftwise',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Roboto',
              visualDensity: VisualDensity.adaptivePlatformDensity,
              pageTransitionsTheme: const PageTransitionsTheme(builders: {
                TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              }),
            ),
            color: Colors.white,
            initialRoute: routeDoctorList,
            routes: {
              routeBookingConfirmation: (BuildContext context) =>
                  const BookingConfirmationScreen(),
              routeDoctorDetails: (BuildContext context) =>
                   DoctorDetailsScreen(),
              routeReviewBooking: (BuildContext context) =>
                   ReviewBookingScreen(),
              routeSelectPackage: (BuildContext context) =>
                   SelectPackageScreen(),
              routeViewBooking: (BuildContext context) => ViewBookingScreen(),
              routeDoctorList: (BuildContext context) => DoctorListScreen()
            }));
  }
}
