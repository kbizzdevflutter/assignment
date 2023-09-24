import 'package:flutter/material.dart';
import 'package:testproject/models/doctordetails_model.dart';
import 'package:testproject/screens/doctor_details_screen.dart';
import 'package:testproject/services/constants.dart';
import 'package:testproject/services/web_services.dart';
import 'package:testproject/utils/preference_helper.dart';
import 'package:testproject/utils/util_styles.dart';

class DoctorListScreen extends StatefulWidget {
  const DoctorListScreen({Key? key}) : super(key: key);

  @override
  State<DoctorListScreen> createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  List<Doctor> doctorsList = [];
  Doctor? doctor;

  getDoctorsList() {
    Webservice.getRequest(
      uri: Global.doctorDetails,
      onSuccess: (response) {
        if (response != null && response != []) {
          doctorsList = getDoctorModelFromJson(response);
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
    getDoctorsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.white,
        title: Text("Doctors",
            style:
                CustomTextStyles.bold(fontColor: Colors.black, fontSize: 22.0)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: doctorsList.length,
              itemBuilder: (context, index) {
                return Column(children: [
                  const Divider(),
                  InkWell(
                    onTap: () {
                      doctor = doctorsList[index];
                      PreferencesHelper.setString("doctorName", doctor!.doctorName);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DoctorDetailsScreen(
                                doctorData: doctor,
                              )));
                    },
                    child: ListTile(
                      leading: ClipOval(
                        child: Image.network(
                          doctorsList[index].image,
                          width: 50, // Adjust the size as needed
                          height: 50, // Adjust the size as needed
                          fit: BoxFit
                              .cover, // Cover the circular area with the image.0
                        ),
                      ),
                      title: Text(
                        doctorsList[index].doctorName,
                        style: CustomTextStyles.semiBold(
                            fontColor: Colors.black, fontSize: 18.0),
                      ),
                    ),
                  ),
                  const Divider()
                ]);
              }),
        ),
      ),
    );
  }
}
