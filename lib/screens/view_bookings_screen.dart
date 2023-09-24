import 'package:flutter/material.dart';
import 'package:testproject/models/viewBookings_model.dart';
import 'package:testproject/services/constants.dart';
import 'package:testproject/services/web_services.dart';
import 'package:testproject/utils/util_styles.dart';

class ViewBookingScreen extends StatefulWidget {
  const ViewBookingScreen({Key? key}) : super(key: key);

  @override
  State<ViewBookingScreen> createState() => _ViewBookingScreenState();
}

class _ViewBookingScreenState extends State<ViewBookingScreen> {
  List<ViewBookingsModel> bookingList = [];
  String? bookingId;
  String? doctorName;
  String? location;
  String? date;
  String? time;

  getBookingList() {
    Webservice.getRequest(
      uri: Global.doctorDetails,
      onSuccess: (response) {
        if (response != null && response != []) {
          bookingList = viewBookingsModelFromJson(response);
          setState(() {});
        }
      },
      onFailure: (v) {},
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBookingList();
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
        title: Text("My Bookings",
            style:
                CustomTextStyles.bold(fontColor: Colors.black, fontSize: 22.0)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: bookingList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                  bottom: 10.0,
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "${bookingList[index].appointmentDate}, ${bookingList[index].appointmentTime}",
                            style: CustomTextStyles.normal(
                                fontSize: 16.0, fontWeight: FontWeight.w900),
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Image.network(
                                    "https://hireforekam.s3.ap-south-1.amazonaws.com/doctors/1-Doctor.png",
                                    width: 100, // Adjust the size as needed
                                    height: 100, // Adjust the size as needed
                                    fit: BoxFit.cover,
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
                                    "${bookingList[index].doctorName}",
                                    style: CustomTextStyles.normal(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  SizedBox(
                                    width: 160,
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          color: Colors.blueAccent,
                                        ),
                                        Flexible(
                                          child: Text(
                                            "${bookingList[index].location}",
                                            style: CustomTextStyles.semiBold(
                                                fontSize: 16.0),
                                            softWrap: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.book,
                                        color: Colors.blueAccent,
                                      ),
                                      Text(
                                          "Booking ID: #${bookingList[index].bookingId}",
                                          style: CustomTextStyles.semiBold(
                                              fontSize: 16.0)),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[50],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20.0), // Adjust the value as needed
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  "Cancel",
                                  style: CustomTextStyles.normal(
                                      fontColor: Colors.blueAccent,
                                      fontSize: 18.0),
                                ),
                              ),
                            ),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20.0), // Adjust the value as needed
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  "Reschedule",
                                  style:
                                      CustomTextStyles.normal(fontSize: 18.0),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
