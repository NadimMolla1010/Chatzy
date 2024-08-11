import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
 final String senderID;
 final String senderEmail;
 final String receiverID;
 final String message;
 final Timestamp timestamp;
 final bool isFile;

 Message({
  required this.senderID,
  required this.senderEmail,
  required this.receiverID,
  required this.message,
  required this.timestamp,
  required this.isFile,
 });

 Map<String, dynamic> toMap() {
  return {
   'senderID': senderID,
   'senderEmail': senderEmail,
   'receiverID': receiverID,
   'message': message,
   'timestamp': timestamp,
   'isFile': isFile,
  };
 }
}
