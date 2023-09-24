import 'package:flutter/material.dart';
import 'package:testproject/models/selectPackage_model.dart';
import 'package:testproject/screens/rview_booking_screen.dart';
import 'package:testproject/services/constants.dart';
import 'package:testproject/services/web_services.dart';
import 'package:testproject/utils/preference_helper.dart';

import '../models/doctordetails_model.dart';
import '../utils/util_styles.dart';

class SelectPackageScreen extends StatefulWidget {
  SelectPackageScreen({Key? key, this.doctorData}) : super(key: key);
  Doctor? doctorData;

  @override
  State<SelectPackageScreen> createState() => _SelectPackageScreenState();
}

class _SelectPackageScreenState extends State<SelectPackageScreen> {
  SelectPackageModel? selectPackageModel;
  List duration = [];
  List<String> package = [];
  String? selectedDuration;
  String? selectedPackage;

  void updateSelectedPackage(String? package) {
    setState(() {
      selectedPackage = package;
      PreferencesHelper.setString(
          "package", selectedPackage ?? ""); // Store the selected package
    });
  }

  Widget customPackage(IconData packageImage, String title, String subTitle,
      String packageValue) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 1, color: Colors.grey)
      ),
      child: ListTile(
        leading: Icon(
          packageImage,
          size: 30,
          color: Colors.blueAccent,
        ),
        title: Text(
          title,
          style: CustomTextStyles.normal(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(subTitle),
        trailing: Radio<String>(
          value: packageValue,
          groupValue: selectedPackage,
          onChanged: (value) {
            setState(() {
              selectedPackage = value;
              PreferencesHelper.setString("package", selectedPackage ?? "");
            });
          },
          activeColor: Colors.blueAccent,
        ),
      ),
    );
  }

  getPackageList() {
    Webservice.getRequest(
      uri: Global.selectPackage,
      onSuccess: (response) {
        if (response != null && response != []) {
          selectPackageModel = selectpackageModelFromJson(response);
          duration = selectPackageModel!.duration!.toList();
          package = selectPackageModel!.package!.toList();
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
    Future.delayed(Duration.zero, () {
      if (mounted) {
        // ignore: prefer_is_empty, unnecessary_null_comparison
        if (widget.doctorData != null) {
          setState(() {});
        }
      }
    });
    getPackageList();
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
        title: Text("Select Package",
            style:
                CustomTextStyles.bold(fontColor: Colors.black, fontSize: 20.0)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Select Duration",
                style: CustomTextStyles.normal(
                    fontWeight: FontWeight.w600, fontSize: 22.0),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: DropdownButton<String>(
                value: selectedDuration,
                onChanged: (newValue) {
                  setState(() {
                    selectedDuration = newValue;
                    PreferencesHelper.setString(
                        "duration", selectedDuration.toString());
                  });
                },
                items: duration.map((duration) {
                  return DropdownMenuItem<String>(
                    value: duration,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          color: Colors.blueAccent,
                        ),
                        const SizedBox(width: 8),
                        Text(duration),
                      ],
                    ),
                  );
                }).toList(),
                isExpanded: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.blueAccent,
                ),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
                underline: Container(
                  height: 0,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Select Package",
                style: CustomTextStyles.normal(
                    fontWeight: FontWeight.w600, fontSize: 22.0),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            customPackage(
              Icons.message,
              "Messaging",
              "Chat with Doctor",
              "Messaging",
            ),
            const SizedBox(
              height: 20,
            ),
            customPackage(Icons.phone, "Voice Call", "Voice call with Doctor",
                "Voice Call"),
            const SizedBox(
              height: 20,
            ),
            customPackage(Icons.video_call, "Video Call",
                "Video call with Doctor", "Video Call"),
            const SizedBox(
              height: 20,
            ),
            customPackage(Icons.person, "In Person",
                "In Person visit with Doctor", "In Person"),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ReviewBookingScreen(
                                doctorData: widget.doctorData,
                              )));
                    },
                    child: const Text("Next"),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
