import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery_admin/main.dart';
import 'package:grocery_admin/models/order.dart';
import 'package:grocery_admin/themes/theme_color.dart';

class MyOrdersCard extends StatelessWidget {
  const MyOrdersCard({Key? key, required this.orders}) : super(key: key);
  final Orders orders;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(12),
        height: mq.height * 0.15,
        child: Row(
          children: [
            // Display the product image
            SizedBox(
              width: 100,
              child: CachedNetworkImage(
                imageUrl: orders.items.first
                    .imgurl, // Assuming you want to show the first product's image
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                    color: HashColorCodes.green,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    orders.shippingAddress
                        .name, // Assuming you want to show the first product's name
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  Text(
                    orders.is_delivered ? 'Delivered' : 'Not Delivered',
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    'Total Price: Rs.${orders.totalPrice.toStringAsFixed(2)}',
                  ),
                  Text(
                    'User Address: ${orders.shippingAddress.city}', // Display the user's address
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
