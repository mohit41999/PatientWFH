// To parse this JSON data, do
//
//     final confirmBooking = confirmBookingFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ConfirmBookingModel confirmBookingFromJson(String str) =>
    ConfirmBookingModel.fromJson(json.decode(str));

String confirmBookingToJson(ConfirmBookingModel data) =>
    json.encode(data.toJson());

class ConfirmBookingModel {
  ConfirmBookingModel({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  Data data;

  factory ConfirmBookingModel.fromJson(Map<String, dynamic> json) =>
      ConfirmBookingModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.bookingId,
    required this.specialty,
    required this.doctorName,
    required this.bookingStatus,
    required this.patientName,
    required this.DoctorProfile,
    required this.patientLocation,
    required this.bookedServiceTime,
    required this.clinicLocation,
    required this.totalAmount,
    required this.amountStatus,
    required this.patientAge,
    required this.Booking_For,
    required this.bookingDate,
    required this.download_report,
  });

  String bookingId;
  String specialty;
  String doctorName;
  String bookingStatus;
  String DoctorProfile;
  String patientName;
  String patientLocation;
  String bookedServiceTime;
  String patientAge;
  String clinicLocation;
  String totalAmount;
  String Booking_For;
  String amountStatus;
  String bookingDate;
  String download_report;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        bookingId: json["Booking Id"],
        specialty: json["Specialty"],
        DoctorProfile: json["Doctor Profile"],
        doctorName: json["Doctor Name"],
        bookingStatus: json["Booking Status"],
        patientAge: json["patient Age"],
        bookingDate: json["Booking Date"],
        patientName: json["Patient Name"],
        patientLocation: json["patient Location"],
        bookedServiceTime: json["Booked Service Time"],
        clinicLocation: json["Clinic Location"],
        totalAmount: json["Total Amount"],
        amountStatus: json["Amount Status"],
        Booking_For: json["Booking For"],
        download_report: json["download_report"],
      );

  Map<String, dynamic> toJson() => {
        "Booking Id": bookingId,
        "Specialty": specialty,
        "Doctor Name": doctorName,
        "Booking Status": bookingStatus,
        "Booking Date": bookingDate,
        "patient Age": patientAge,
        "Patient Name": patientName,
        "patient Location": patientLocation,
        "Doctor Profile": DoctorProfile,
        "Booked Service Time": bookedServiceTime,
        "Clinic Location": clinicLocation,
        "Total Amount": totalAmount,
        "Amount Status": amountStatus,
        "Booking For": Booking_For,
        "download_report": download_report,
      };
}
