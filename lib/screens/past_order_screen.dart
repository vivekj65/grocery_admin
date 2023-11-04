import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_admin/api/apis.dart';
import 'package:grocery_admin/models/order.dart';
import 'package:grocery_admin/screens/order_info_screen.dart';
import 'package:grocery_admin/themes/theme_color.dart';
import 'package:grocery_admin/widget/my_order_card.dart';

class PastOrderScreen extends StatefulWidget {
  const PastOrderScreen({super.key});

  @override
  State<PastOrderScreen> createState() => _PastOrderScreenState();
}

class _PastOrderScreenState extends State<PastOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Delivered Orders",
            style: TextStyle(
              fontFamily: 'Sarala',
              color: HashColorCodes.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: HashColorCodes.green,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: APIs.pastOrders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print('Error: ${snapshot.error}'); // Log the error message
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              print('No Orders Placed yet'); // Log a message
              return const Center(child: Text('No Orders Placed yet'));
            } else {
              final items = snapshot.data!.docs.map((document) {
                final itemData = document.data() as Map<String, dynamic>;
                return Orders.fromMap(itemData);
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
                          builder: (_) => OrderDetailsScreen(order: item),
                        ),
                      );
                    },
                    child: MyOrdersCard(
                      orders: item,
                    ),
                  );
                },
              );
            }
          },
        ));
  }
}
