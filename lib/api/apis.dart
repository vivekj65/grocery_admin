import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:grocery_admin/models/banner.dart';
import 'package:grocery_admin/models/product.dart';

class APIs {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore fireStore = FirebaseFirestore.instance;
  static FirebaseStorage imageStore = FirebaseStorage.instance;

  static Future<void> uploadProduct(Product product) async {
    final CollectionReference productsCollection =
        fireStore.collection('products');
    Map<String, dynamic> productData = product.toMap();
    await productsCollection.add(productData);

    log('Product uploaded successfully');
  }

  static Future<void> deleteProduct(String documentId) async {
    final CollectionReference productsCollection =
        fireStore.collection('products');
    await productsCollection.doc(documentId).delete();
    log(documentId);
    log("$productsCollection");
    log('Product deleted successfully');
  }

  static Future<void> uploadBanner(Carousal carousal) async {
    final CollectionReference bannerCollection = fireStore.collection('banner');
    Map<String, dynamic> productData = carousal.toJson();
    await bannerCollection.add(productData);
    log('Banner uploaded successfully');
  }

  static Future<List<Carousal>> getCarousal() async {
    List<Carousal> carousals = [];

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await fireStore.collection('banner').get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
      carousals.add(
        Carousal.fromJson(doc.data() as Map<String, dynamic>),
      );
    }
    log("Crousal Length ${carousals.length}");
    return carousals;
  }

  // static Future<void> deleteBanner(String documentId) async {
  //   final CollectionReference productsCollection =
  //       fireStore.collection('banner');
  //   try {
  //     await productsCollection.doc(documentId).delete();
  //     log('Banner deleted successfully ' + documentId);
  //   } catch (e) {
  //     log('Error deleting banner: $e');
  //   }
  // }

  static Future<void> deleteBanner(String documentId) async {
    final CollectionReference productsCollection =
        FirebaseFirestore.instance.collection('banner');
    await productsCollection.doc(documentId).delete();
  }

  static Stream<QuerySnapshot> getOrders() {
    return FirebaseFirestore.instance
        .collectionGroup('user_orders')
        .where('orderStatus', isEqualTo: false)
        .snapshots();
  }

  static Stream<QuerySnapshot> pastOrders() {
    return FirebaseFirestore.instance
        .collectionGroup('user_orders')
        .where('orderStatus', isEqualTo: true)
        .snapshots();
  }

  static Future<String> getDocumentIdByOrderId(String orderId) async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('orders')
        .where('orderId', isEqualTo: orderId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.id;
    } else {
      throw Exception("No matching document found for orderId: $orderId");
    }
  }

  // Function to update the delivery status of an order
  static Future<void> updateOrderDeliveryStatus(
      String orderId, bool isDelivered) async {
    try {
      final orderDocumentId = await getDocumentIdByOrderId(orderId);

      if (orderDocumentId != null) {
        await FirebaseFirestore.instance
            .collection('orders')
            .doc(orderDocumentId)
            .update({'is_delivered': isDelivered});

        log("Order delivery status updated successfully.");
      } else {
        log("Order with orderId: $orderId not found in the database.");
      }
    } catch (error) {
      log("Error updating order delivery status: $error");
      // Handle the error as needed
    }
  }

  static Future<void> updateProducts(
      String parentDocumentId, String childDocumentId, bool isDelivered) async {
    try {
      if (parentDocumentId.isNotEmpty && childDocumentId.isNotEmpty) {
        final parentDocument = await FirebaseFirestore.instance
            .collection('orders')
            .doc(parentDocumentId)
            .get();

        if (parentDocument.exists) {
          // Parent document exists, update the child document
          await parentDocument.reference
              .collection('user_orders')
              .doc(childDocumentId)
              .update({'is_delivered': isDelivered});

          log('Product updated successfully.');
          log("Parent Document ID: $parentDocumentId");
          log("Child Document ID: $childDocumentId");
        } else {
          log('Error: Parent Document with ID $parentDocumentId not found.');
        }
      } else {
        print('Error: Document IDs are empty or null.');
      }
    } catch (e) {
      log('Error updating product: $e');
      log("Parent Document ID: $parentDocumentId");
      log("Child Document ID: $childDocumentId");
    }
  }

  static Future<void> updateProduct(
      String nestedDocumentId, bool isDelivered) async {
    try {
      if (nestedDocumentId.isNotEmpty) {
        final userOrderDocument = await FirebaseFirestore.instance
            .collectionGroup(
                'user_orders') // Access all documents in the 'user_orders' subcollection
            .where(FieldPath.documentId, isEqualTo: nestedDocumentId)
            .get();

        if (userOrderDocument.docs.isNotEmpty) {
          // Document exists, update it
          await userOrderDocument.docs.first.reference
              .update({'is_delivered': isDelivered});
          log('User order status updated successfully.');
          log("Nested Document ID: $nestedDocumentId");
        } else {
          print('Error: Nested document with ID $nestedDocumentId not found.');
        }
      } else {
        print('Error: Document ID is empty or null.');
      }
    } catch (e) {
      log('Error updating user order status: $e');
      log("Nested Document ID: $nestedDocumentId");
    }
  }
}
