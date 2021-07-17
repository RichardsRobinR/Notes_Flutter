import 'package:cloud_firestore/cloud_firestore.dart';

class Users {

  final String fullName ;
  final String company ;
  final int age ;


  Users({required this.fullName, required this.company,required this.age});

  Users.fromJson(Map<String, Object?> json)
      : this(
    fullName: json['fullName']! as String,
    company: json['company']! as String,
    age: json['age']! as int,
  );


  Map<String, Object?> toJson() {
    return {
      'fullName': fullName,
      'company': company,
    };



  }


}