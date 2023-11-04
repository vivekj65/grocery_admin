import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:grocery_admin/api/apis.dart';
import 'package:grocery_admin/models/order.dart';
import 'package:grocery_admin/themes/theme_color.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Orders order;

  OrderDetailsScreen({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Order Details",
          style: TextStyle(
            fontFamily: 'Sarala',
            color: HashColorCodes.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: HashColorCodes.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Shipping Address:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(order.shippingAddress.name),
                  Text(
                    order.is_delivered ? 'Delivered' : 'Not Delivered',
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(order.shippingAddress.city),
                  Text(order.shippingAddress.streetAddress),
                  Text(order.shippingAddress.postalCode),
                  Text(order.shippingAddress.phoneNo),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Products (${order.items.length}):',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: order.items.length,
              itemBuilder: (context, index) {
                final item = order.items[index];
                return ListTile(
                  leading: SizedBox(
                    width: 100,
                    child: CachedNetworkImage(
                      imageUrl: item.imgurl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  title: Text(item.productName),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Total Price: Rs.${order.totalPrice.toString()}',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: ElevatedButton(
                onPressed: () {
                  APIs.updateProduct(order.documentId, true);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: HashColorCodes.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 1,
                  ),
                ),
                child: const Text(
                  'Deliverd',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: HashColorCodes.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
