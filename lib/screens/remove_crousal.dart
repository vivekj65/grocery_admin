import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery_admin/api/apis.dart';
import 'package:grocery_admin/models/banner.dart';
import 'package:grocery_admin/themes/theme_color.dart';

class RemoveCarousal extends StatefulWidget {
  const RemoveCarousal({Key? key});

  @override
  State<RemoveCarousal> createState() => _RemoveCarousalState();
}

class _RemoveCarousalState extends State<RemoveCarousal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: HashColorCodes.green,
          title: const Text(
            "Remove Carousel",
            style: TextStyle(
              fontFamily: 'Sarala',
              color: HashColorCodes.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: FutureBuilder<List<Carousal>>(
          future: APIs.getCarousal(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<Carousal> carousels = snapshot.data ?? [];
              log("Carousels length: ${carousels.length}");

              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    CarouselSlider(
                      options: CarouselOptions(height: 175.0),
                      items: carousels.map((carousel) {
                        return Builder(
                          builder: (BuildContext context) {
                            return InkWell(
                              onLongPress: () {
                                APIs.deleteBanner(carousel.id);
                                log("jh" + carousel.documentId);
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: CachedNetworkImage(
                                        imageUrl: carousel.imgUrl,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                    CircularProgressIndicator(
                                          color: HashColorCodes.green,
                                        )),
                                        errorWidget: (context, url, error) {
                                          // log("Image URL (Error): $url");
                                          return const Icon(Icons.error);
                                        },
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 16.0,
                                      bottom: 16.0,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            carousel.title,
                                            style: const TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                              color: HashColorCodes.green,
                                            ),
                                          ),
                                          Text(
                                            carousel.description,
                                            style: const TextStyle(
                                              fontSize: 16.0,
                                              color: HashColorCodes.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            }
          },
        ));
  }
}
