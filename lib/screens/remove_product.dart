import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:grocery_admin/models/product.dart';
import 'package:grocery_admin/themes/theme_color.dart';
import 'package:grocery_admin/widget/product_card.dart';

class RemoveProduct extends StatefulWidget {
  const RemoveProduct({
    super.key,
  });
  @override
  State<RemoveProduct> createState() => _RemoveProductState();
}

class _RemoveProductState extends State<RemoveProduct> {
  TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Delete Product",
          style: TextStyle(
            fontFamily: 'Sarala',
            color: HashColorCodes.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: HashColorCodes.green,
      ),
      body: Column(children: [
        Container(
          margin: const EdgeInsets.all(10),
          height: 50.0,
          decoration: const BoxDecoration(
            color: HashColorCodes.screenGrey,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: TextField(
            controller: _searchController, // Attach controller
            onChanged: (value) {
              setState(() {
                searchQuery = value.toLowerCase();
              });
            },
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: HashColorCodes.borderGrey,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: HashColorCodes.borderGrey,
                ),
              ),
              hintText: 'Search Product',
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('products').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: HashColorCodes.green,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<Product> products = snapshot.data!.docs
                  .map((doc) => Product.fromDocumentSnapshot(doc))
                  .toList();

              List<Product> searchResults = products
                  .where((product) =>
                      product.name.toLowerCase().contains(searchQuery) ||
                      product.category.toLowerCase().contains(searchQuery))
                  .toList();

              if (searchResults.isEmpty) {
                return const Center(
                  child: Text('No items found'),
                );
              }

              return Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      product: searchResults[index],
                    );
                  },
                ),
              );
            }
          },
        ),
      ]),
    );
  }
}
