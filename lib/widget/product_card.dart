import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_admin/api/apis.dart';
import 'package:grocery_admin/main.dart';
import 'package:grocery_admin/models/product.dart';
import 'package:grocery_admin/themes/theme_color.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: HashColorCodes.productGrey,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: HashColorCodes.borderGrey,
          width: .2,
        ),
      ),
      child: Column(children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: mq.height * .1,
              width: mq.width * .54,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CachedNetworkImage(
                  imageUrl: product.imgurl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                    color: HashColorCodes.green,
                  )),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Urbanist'),
                ),
                ElevatedButton(
                  onPressed: () {
                    APIs.deleteProduct(product.documentId);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HashColorCodes.red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 1,
                    ),
                  ),
                  child: const Text(
                    'Delete Product',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: HashColorCodes.white,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              '${product.description.split(' ').take(3).join(' ')}...',
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Urbanist'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rs. ${product.price.toString()}',
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Urbanist',
                      color: HashColorCodes.green),
                ),
                Text(
                  "${product.discount}% off",
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Urbanist'),
                ),
              ],
            ),
          ]),
        ),
      ]),
    );
  }
}
