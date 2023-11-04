// import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class Carousal {
  final String id;
  String imgUrl;
  final String redirectUrl;
  String title;
  final String description;
  String documentId;

  Carousal({
    required this.id,
    required this.imgUrl,
    required this.redirectUrl,
    required this.title,
    required this.description,
    required this.documentId,
  });

  factory Carousal.fromJson(Map<String, dynamic> json) {
    return Carousal(
      id: json['id'] ?? '',
      imgUrl: json['imgurl'] ?? '',
      redirectUrl: json['redirecturl'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      documentId: json['documentId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imgurl': imgUrl,
      'redirectUrl': redirectUrl,
      'title': title,
      'description': description,
      'documentId': documentId,
    };
  }

  factory Carousal.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final bannerId = doc.id;
    final carousal = Carousal.fromJson(data);
    carousal.documentId = bannerId;
    return carousal;
  }
}
