// To parse this JSON data, do
//
//     final doctorProfileOneModel = doctorProfileOneModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DoctorProfileOneModel doctorProfileOneModelFromJson(String str) =>
    DoctorProfileOneModel.fromJson(json.decode(str));

String doctorProfileOneModelToJson(DoctorProfileOneModel data) =>
    json.encode(data.toJson());

class DoctorProfileOneModel {
  DoctorProfileOneModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  DoctorProfileOneModelData data;

  factory DoctorProfileOneModel.fromJson(Map<String, dynamic> json) =>
      DoctorProfileOneModel(
        status: json["status"],
        message: json["message"],
        data: DoctorProfileOneModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class DoctorProfileOneModelData {
  DoctorProfileOneModelData({
    required this.doctorDetails,
    required this.clinicDetails,
    required this.clinicImages,
  });

  DoctorDetails doctorDetails;
  ClinicDetails clinicDetails;
  List<ClinicImage> clinicImages;

  factory DoctorProfileOneModelData.fromJson(Map<String, dynamic> json) =>
      DoctorProfileOneModelData(
        doctorDetails: DoctorDetails.fromJson(json["Doctor Details"]),
        clinicDetails: ClinicDetails.fromJson(json["Clinic Details"]),
        clinicImages: List<ClinicImage>.from(
            json["Clinic_images"].map((x) => ClinicImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Doctor Details": doctorDetails.toJson(),
        "Clinic Details": clinicDetails.toJson(),
        "Clinic_images":
            List<dynamic>.from(clinicImages.map((x) => x.toJson())),
      };
}

class ClinicDetails {
  ClinicDetails({
    required this.clinicName,
    required this.location,
    required this.fromToDays,
    required this.openCloseTime,
    required this.oflineConsultancyFees,
    required this.doctorAvailabilityStatus,
  });

  String clinicName;
  String location;
  String fromToDays;
  String openCloseTime;
  String oflineConsultancyFees;
  String doctorAvailabilityStatus;

  factory ClinicDetails.fromJson(Map<String, dynamic> json) => ClinicDetails(
        clinicName: json["clinic_name"],
        location: json["location"],
        fromToDays: json["from_to_days"],
        openCloseTime: json["open_close_time"],
        oflineConsultancyFees: json["ofline_consultancy_fees"],
        doctorAvailabilityStatus: json["doctor_availability_status"],
      );

  Map<String, dynamic> toJson() => {
        "clinic_name": clinicName,
        "location": location,
        "from_to_days": fromToDays,
        "open_close_time": openCloseTime,
        "ofline_consultancy_fees": oflineConsultancyFees,
        "doctor_availability_status": doctorAvailabilityStatus,
      };
}

class ClinicImage {
  ClinicImage({
    required this.clinicImages,
  });

  String clinicImages;

  factory ClinicImage.fromJson(Map<String, dynamic> json) => ClinicImage(
        clinicImages: json["clinic_images"],
      );

  Map<String, dynamic> toJson() => {
        "clinic_images": clinicImages,
      };
}

class DoctorDetails {
  DoctorDetails({
    required this.doctorName,
    required this.education,
    required this.specialist,
    required this.languageSpoken,
    required this.experience,
    required this.about_me,
    required this.profile_image,
  });

  String doctorName;
  String education;
  String specialist;
  String languageSpoken;
  String experience;
  String about_me;
  String profile_image;

  factory DoctorDetails.fromJson(Map<String, dynamic> json) => DoctorDetails(
        doctorName: json["doctor_name"],
        education: json["education"],
        specialist: json["specialist"],
        languageSpoken: json["language_spoken"],
        experience: json["experience"],
        about_me: json["about_me"],
        profile_image: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "doctor_name": doctorName,
        "education": education,
        "specialist": specialist,
        "language_spoken": languageSpoken,
        "experience": experience,
        "about_me": about_me,
        "profile_image": profile_image,
      };
}
