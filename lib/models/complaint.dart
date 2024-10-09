import 'package:cloud_firestore/cloud_firestore.dart';

class ComplaintMessage {
  final String senderemail;
  final String name;
  final String phonenumber;
  final String senderid;
  final String complaint;
  final String brand;
  final String type;
  final Timestamp timestamp;

  ComplaintMessage({
    required this.senderemail,
    required this.senderid,
    required this.type,
    required this.name,
    required this.phonenumber,
    required this.brand,
    required this.complaint,
    required this.timestamp,
  });

  //convert to map
  Map<String, dynamic> toMap() {
    return {
      'senderemail': senderemail,
      'senderid': senderid,
      'type': type,
      'name': name,
      'phonenumber': phonenumber,
      'brand': brand,
      'complaint': complaint,
      'timestamp': timestamp,
    };
  }
}
