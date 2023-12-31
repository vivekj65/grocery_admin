import 'package:grocery_admin/models/cart_items.dart';
import 'package:grocery_admin/models/shipping_address.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Orders {
  final String orderId;
  String documentId;
  final String userId;
  final items;
  final double totalPrice;
  final ShippingAddress shippingAddress;
  final DateTime orderDate;
  final bool is_delivered;
  // final String imgurl;
  // final String ProdutName;

  Orders({
    required this.userId,
    required this.orderId,
    required this.documentId,
    // required this.ProdutName,
    required this.items,
    required this.totalPrice,
    required this.shippingAddress,
    required this.orderDate,
    required this.is_delivered,
  });

  // Convert Order object to a Map
  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'documentId': documentId,
      'userId': userId,
      'items': items.map((item) => item.toMap()).toList(),
      'totalPrice': totalPrice,
      'shippingAddress': shippingAddress.toMap(),
      'orderDate': orderDate.toUtc().toIso8601String(),
      'orderStatus': is_delivered,
    };
  }

  // Create an Order object from a Map
  factory Orders.fromMap(Map<String, dynamic> map) {
    return Orders(
      orderId: map['orderId'],
      documentId: map['documentId'] ?? '',
      userId: map['userId'],
      items: List<CartItem>.from(
          map['items'].map((item) => CartItem.fromMap(item))),
      totalPrice: map['totalPrice'],
      shippingAddress: ShippingAddress.fromMap(map['shippingAddress']),
      orderDate: DateTime.parse(map['orderDate']),
      is_delivered: map['orderStatus'],
    );
  }
}
