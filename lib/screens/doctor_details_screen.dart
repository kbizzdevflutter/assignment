import 'package:flutter/material.dart';
import 'package:testproject/models/doctordetails_model.dart';
import 'package:testproject/screens/select_package_screen.dart';
import 'package:testproject/utils/preference_helper.dart';
import 'package:testproject/utils/util_methods.dart';
import 'package:testproject/utils/util_styles.dart';
import 'package:testproject/utils/util_widgets.dart';

class DoctorDetailsScreen extends StatefulWidget {
  DoctorDetailsScreen({Key? key, this.doctorData}) : super(key: key);
  Doctor? doctorData;

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  String? doctorName;
  String? doctorImage;
  String? speciality;
  String? location;
  String? patients;
  String? experience;
  String? noOfReviews;
  String? rating;
  List<String>? availabilityDates;
  Map<String, List<String>> availabilityTimes = {};

  String? selectedDate;
  String? selectedTime;

  List<String> extractAllInitialTimes(String selectedDate) {
    final timeSlots = widget.doctorData!.availability[selectedDate] ?? [];
    final List<String> initialTimes = [];

    for (String slot in timeSlots) {
      final parts = slot.split(' - ');
      if (parts.isNotEmpty) {
        final startTime = parts[0];
        initialTimes.add(startTime);
      }
    }

    return initialTimes;
  }

  Widget buildAvailabilityDates() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "DAY",
            style: CustomTextStyles.normal(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (String date in availabilityDates!)
              OvalAvailabilityDate(
                date: date,
                onDateSelected: (selectedDate) {
                  setState(() {
                    this.selectedDate = selectedDate;
                    PreferencesHelper.setString("date", selectedDate);
                  });
                },
                isSelected: date == selectedDate,
                timeSlots: availabilityTimes[date] ?? [],
              ),
          ],
        ),
        const SizedBox(height: 20), 
        if(selectedDate != null)
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "TIME",
              style: CustomTextStyles.normal(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

           for(String time in extractAllInitialTimes(selectedDate.toString()))
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OvalAvailabilityTime(
                      time: time,
                      isSelected: time == selectedTime,
                    onTimeSelected: (selectedTime){
                        setState(() {
                          this.selectedTime =selectedTime;
                          PreferencesHelper.setString("time", selectedTime);
                        });
                    },),
                  ),
            ],
          ),
        ),
        /*const Row(
          mainAxisAlignment: MainAxisAlignment.start,
        )*/
      ],
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      if (mounted) {

        // ignore: prefer_is_empty, unnecessary_null_comparison
        if (widget.doctorData != null) {
          doctorName = widget.doctorData!.doctorName;
          doctorImage = widget.doctorData!.image;
          speciality = widget.doctorData!.speciality;
          location = widget.doctorData!.location;
          patients = widget.doctorData!.patientsServed.toString();
          experience = widget.doctorData!.yearsOfExperience.toString();
          noOfReviews = widget.doctorData!.number_of_reviews.toString();
          rating = widget.doctorData!.rating.toString();
          availabilityDates = widget.doctorData!.availability.keys.toList();
          




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
        title: Text("Book Appointment",
            style:
                CustomTextStyles.bold(fontColor: Colors.black, fontSize: 22.0)),
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
          const Divider(
            thickness: 2,
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customStats(Icons.people, patients, "Patients"),
                customStats(
                    Icons.shopping_bag_outlined, experience, "Years Exp."),
                customStats(Icons.star, rating, "Rating"),
                customStats(Icons.chat, noOfReviews, "Review"),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text("BOOK APPOINTMENT",
                style: CustomTextStyles.normal(
                    fontSize: 18.0, fontColor: Colors.grey)),
          ),
          if (availabilityDates != null && availabilityDates!.isNotEmpty)
            buildAvailabilityDates(),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 350,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20.0), // Adjust the value as needed
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SelectPackageScreen(
                          doctorData: widget.doctorData,
                        )));
                  },
                  child: const Text("Make Appointment"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
