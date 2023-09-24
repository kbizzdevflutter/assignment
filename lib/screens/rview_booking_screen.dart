import 'package:flutter/material.dart';
import 'package:testproject/models/doctordetails_model.dart';
import 'package:testproject/services/constants.dart';
import 'package:testproject/services/web_services.dart';
import 'package:testproject/utils/util_methods.dart';
import 'package:testproject/utils/util_routes.dart';
import 'package:testproject/utils/util_styles.dart';

import '../utils/preference_helper.dart';
 class ReviewBookingScreen extends StatefulWidget {
    ReviewBookingScreen({this.doctorData, Key? key}) : super(key: key);
 Doctor? doctorData;
   @override
   State<ReviewBookingScreen> createState() => _ReviewBookingScreenState();
 }
 
 class _ReviewBookingScreenState extends State<ReviewBookingScreen> {
   String? doctorName;
   String? doctorImage;
   String? speciality;
   String? location;

   String? duration;
   String? date;
   String? package;

   Future getBookingDetails() async {
     duration = await PreferencesHelper.getString("duration");
     date = await PreferencesHelper.getString("date");
     package = await PreferencesHelper.getString("package");
     setState(() {});
   }

   confirmBooking(){
    /* var body = {
       "doctor_name": doctorName,
       "appointment_date": date,
       "appointment_time": "09:00 AM - 09:30 AM",
       "location": location,
       "appointment_package": "Video Call"
     };*/
     Webservice.getRequest(
       context: context,
       uri: Global.bookingConfirmation,
       /*body: body,*/
       onSuccess: (response){
         if (response != null && response != []) {
           Navigator.pushNamed(context, routeBookingConfirmation);
           setState(() {});
         }
       }
     );
   }


   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBookingDetails();
    Future.delayed(Duration.zero, () {
      if (mounted) {

        // ignore: prefer_is_empty, unnecessary_null_comparison
        if (widget.doctorData != null) {
          doctorName = widget.doctorData!.doctorName;
          doctorImage = widget.doctorData!.image;
          speciality = widget.doctorData!.speciality;
          location = widget.doctorData!.location;
          setState(() {});
        }
      }
    });
  }
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         leading: const BackButton(color: Colors.black,),
         forceMaterialTransparency: true,
         backgroundColor: Colors.white,
         title: Text("Review Summary",
             style:
             CustomTextStyles.bold(fontColor: Colors.black, fontSize: 20.0)),
         centerTitle: true,
       ),
       body: Column(
         children: [
           Container(
             padding: const EdgeInsets.all(20),
             child: Row(
               children: [
                 Stack(
                   children: [
                     ClipOval(
                       child: Image.network(
                         doctorImage.toString(),
                         width: 100, // Adjust the size as needed
                         height: 100, // Adjust the size as needed
                         fit: BoxFit.cover,
                       ),
                     ),
                     const Positioned(
                       bottom: 0,
                       right: 0,
                       child: Icon(
                         Icons.verified,
                         color:  Colors.blueAccent, // Customize the color as needed
                         size: 20, // Customize the size as needed
                       ),
                     ),
                   ],
                 ),
                 const SizedBox(
                   width: 10,
                 ),
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(
                       doctorName.toString(),
                       style: CustomTextStyles.normal(
                           fontSize: 20.0, fontWeight: FontWeight.w900),
                     ),
                     Text(speciality.toString(),
                         style: CustomTextStyles.semiBold(fontSize: 18.0)),
                     const SizedBox(
                       height: 5,
                     ),
                     SizedBox(
                       width: 200,
                       child: Row(
                         children: [
                           const Icon(
                             Icons.location_on,
                             color:  Colors.blueAccent,
                           ),
                           Flexible(
                             child: Text(
                               location.toString(),
                               style: CustomTextStyles.semiBold(fontSize: 16.0),
                               softWrap: true,
                             ),
                           ),
                           const Icon(
                             Icons.map,
                             color:  Colors.blueAccent,
                           ),
                         ],
                       ),
                     ),
                   ],
                 )
               ],
             ),
           ),
           const Divider(),
           customConfirmation(
             question: "Date & Hour",
             answer: date
           ),
           customConfirmation(
               question: "Package",
               answer: package
           ),
           customConfirmation(
               question: "Duration",
               answer: duration
           ),
           customConfirmation(
               question: "Booking for",
               answer: "Self"
           ),
           Expanded(
             child: Align(
               alignment: Alignment.bottomCenter,
               child: Container(
                 width: 350,
                 margin: const EdgeInsets.only(bottom: 10),
                 child: ElevatedButton(
                   style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.blueAccent,
                     shape: RoundedRectangleBorder(
                       borderRadius:
                       BorderRadius.circular(20.0), // Adjust the value as needed
                     ),
                   ),
                   onPressed: () {
                    confirmBooking();

                   },
                   child: const Text("Confirm"),
                 ),
               ),
             ),
           )
         ],
       ),

     );
   }
 }
 