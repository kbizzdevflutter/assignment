import 'dart:convert';

SelectPackageModel selectpackageModelFromJson(String str) =>
    SelectPackageModel.fromJson(json.decode(str));

class SelectPackageModel {
  List<String>? duration;
  List<String>? package;

  SelectPackageModel({this.duration, this.package});

  SelectPackageModel.fromJson(Map<String, dynamic> json) {
    duration = json['duration'].cast<String>();
    package = json['package'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['duration'] = this.duration;
    data['package'] = this.package;
    return data;
  }
}