import 'dart:convert';

List<Doctor> getDoctorModelFromJson(String str) =>
    List<Doctor>.from(json.decode(str).map((x) => Doctor.fromJson(x)));

class Doctor {
  final String doctorName;
  final String image;
  final String speciality;
  final String location;
  final dynamic patientsServed;
  final dynamic yearsOfExperience;
  final dynamic rating;
  final dynamic number_of_reviews;
  final Map<String, List<String>> availability;

  Doctor({
    required this.doctorName,
    required this.image,
    required this.speciality,
    required this.location,
    required this.patientsServed,
    required this.yearsOfExperience,
    required this.rating,
    required this.number_of_reviews,
    required this.availability,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic>? availabilityJson = json['availability'];
    Map<String, List<String>> availability = {};

    if (availabilityJson != null && availabilityJson is Map<String, dynamic>) {
      availabilityJson.forEach((key, value) {
        if (value is List<dynamic>) {
          availability[key] = value.cast<String>();
        }
      });
    }

    return Doctor(
      doctorName: json['doctor_name'] ?? '',
      image: json['image'] ?? '',
      speciality: json['speciality'] ?? '',
      location: json['location'] ?? '',
      patientsServed: json['patients_served'] ?? 0,
      yearsOfExperience: json['years_of_experience'] ?? 0,
      rating: json['rating'] ?? 0.0,
      number_of_reviews: json['number_of_reviews'] ?? 0,
      availability: availability,
    );
  }
}
