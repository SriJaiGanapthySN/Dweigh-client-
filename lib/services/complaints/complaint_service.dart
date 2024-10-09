import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dweigh/models/complaint.dart';

class ComplaintService {
  //instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create complaint
  Future<void> createComplaint(
      String name, String number, String type, String brand, String complaint) {
    //user values
    final String currentUserId = _auth.currentUser!.uid;
    final String currentEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //creating the complaint
    ComplaintMessage newcomplaint = ComplaintMessage(
        senderemail: currentEmail,
        senderid: currentUserId,
        type: type,
        name: name,
        phonenumber: number,
        brand: brand,
        complaint: complaint,
        timestamp: timestamp);

    //save to firestore
    return _firestore
        .collection("Complaints")
        .doc(type)
        .collection("Complaints")
        .add(
          newcomplaint.toMap(),
        );
  }
}
