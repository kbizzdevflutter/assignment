import 'dart:convert';

List<ViewBookingsModel> viewBookingsModelFromJson(String str) =>
    List<ViewBookingsModel>.from(
        json.decode(str).map((x) => ViewBookingsModel.fromJson(x)));

class ViewBookingsModel {
  String? bookingId;
  String? doctorName;
  String? location;
  String? appointmentDate;
  String? appointmentTime;

  ViewBookingsModel(
      {this.bookingId,
      this.doctorName,
      this.location,
      this.appointmentDate,
      this.appointmentTime});

  ViewBookingsModel.fromJson(Map<String, dynamic> json) {
    bookingId = json["booking_id"];
    doctorName = json["doctor_name"];
    location = json["location"];
    appointmentDate = json["appointment_date"];
    appointmentTime = json["appointment_time"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["booking_id"] = bookingId;
    _data["doctor_name"] = doctorName;
    _data["location"] = location;
    _data["appointment_date"] = appointmentDate;
    _data["appointment_time"] = appointmentTime;
    return _data;
  }
}
