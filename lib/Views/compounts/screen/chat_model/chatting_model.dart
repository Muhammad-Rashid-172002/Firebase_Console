import 'package:cloud_firestore/cloud_firestore.dart';

class ChattingModel {
  final String senderId;
  final String senderEmail;
  final String recieverId;
  final String message;
  final Timestamp timestamp;
  final String? imageUrl;

  ChattingModel({
    required this.senderId,
    required this.senderEmail,
    required this.recieverId,
    required this.message,
    required this.timestamp,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'recieverId': recieverId,
      'message': message,
      'timestamp': timestamp,
    };
  }

  factory ChattingModel.fromMap(Map<String, dynamic> map) {
    return ChattingModel(
      senderId: map['senderId'],
      senderEmail: map['senderEmail'],
      recieverId: map['recieverId'],
      message: map['message'],
      timestamp: map['timestamp'],
      imageUrl: map['imageUrl'], // Add this line to include imageUrl
    );
  }
}
