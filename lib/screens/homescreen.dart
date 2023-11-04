import 'package:flutter/material.dart';
import 'package:grocery_admin/api/apis.dart';
import 'package:grocery_admin/main.dart';
import 'package:grocery_admin/screens/login_screen.dart';
import 'package:grocery_admin/screens/new_orders_screen.dart';
import 'package:grocery_admin/screens/past_order_screen.dart';
import 'package:grocery_admin/screens/remove_crousal.dart';
import 'package:grocery_admin/screens/remove_product.dart';
import 'package:grocery_admin/screens/upload_crousal.dart';
import 'package:grocery_admin/screens/upload_product.dart';
import 'package:grocery_admin/themes/theme_color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String productName = '';
  String productDescription = '';
  double productPrice = 0.0;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: HashColorCodes.green,
        title: const Text(
          "Grocery Admin",
          style: TextStyle(
            fontFamily: 'Sarala',
            color: HashColorCodes.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(14),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const UploadProduct()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: mq.height * .20,
                      width: mq.width * .44,
                      decoration: BoxDecoration(color: HashColorCodes.green),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Upload Product",
                            style: TextStyle(
                                fontFamily: 'Sarala',
                                color: HashColorCodes.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                          Icon(
                            Icons.upload,
                            color: HashColorCodes.white,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => RemoveProduct()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: mq.height * .20,
                      width: mq.width * .44,
                      decoration: BoxDecoration(color: HashColorCodes.green),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Remove Product",
                            style: TextStyle(
                                fontFamily: 'Sarala',
                                color: HashColorCodes.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                          Icon(
                            Icons.delete,
                            color: HashColorCodes.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 13,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => NewOrderScreen()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: mq.height * .20,
                      width: mq.width * .44,
                      decoration: BoxDecoration(color: HashColorCodes.green),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "New Orders",
                            style: TextStyle(
                                fontFamily: 'Sarala',
                                color: HashColorCodes.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                          Icon(
                            Icons.upload,
                            color: HashColorCodes.white,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => PastOrderScreen()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: mq.height * .20,
                      width: mq.width * .44,
                      decoration: BoxDecoration(color: HashColorCodes.green),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Past Orders",
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Sarala',
                              color: HashColorCodes.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.upload,
                            color: HashColorCodes.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 13,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => UploadCrousal()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: mq.height * .20,
                      width: mq.width * .44,
                      decoration:
                          const BoxDecoration(color: HashColorCodes.green),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Add Crousale",
                            style: TextStyle(
                                fontFamily: 'Sarala',
                                color: HashColorCodes.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                          Icon(
                            Icons.upload,
                            color: HashColorCodes.white,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const RemoveCarousal()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: mq.height * .20,
                      width: mq.width * .44,
                      decoration: const BoxDecoration(
                        color: HashColorCodes.green,
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Delete Crousale",
                            style: TextStyle(
                                fontFamily: 'Sarala',
                                color: HashColorCodes.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                          Icon(
                            Icons.delete,
                            color: HashColorCodes.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: HashColorCodes.green,
        onPressed: () async {
          await APIs.auth.signOut().then((value) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const LoginScreen()));
          });
        },
        child: const Icon(Icons.logout),
      ),
    );
  }
}
