import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_admin/api/apis.dart';
import 'package:grocery_admin/models/order.dart';
import 'package:grocery_admin/screens/order_info_screen.dart';
import 'package:grocery_admin/themes/theme_color.dart';
import 'package:grocery_admin/widget/my_order_card.dart';

class NewOrderScreen extends StatefulWidget {
  const NewOrderScreen({super.key});

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "New Orders",
          style: TextStyle(
            fontFamily: 'Sarala',
            color: HashColorCodes.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: HashColorCodes.green,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: APIs.getOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No Orders Placed yet'));
          } else {
            final items = snapshot.data!.docs.map((document) {
              final itemData = document.data() as Map<String, dynamic>;
              final documentId = document.id; // Get the document ID
              itemData['documentId'] = documentId; // Add documentId to itemData
              final order =
                  Orders.fromMap(itemData); // Pass the data with documentId
              return order; // Return the Orders object
            }).toList();

            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => OrderDetailsScreen(order: item)));
                  },
                  child: MyOrdersCard(
                    orders: item,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
