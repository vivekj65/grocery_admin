import 'dart:io';
import 'package:flutter/material.dart';
import 'package:grocery_admin/api/apis.dart';
import 'package:grocery_admin/common/dialogs.dart';
import 'package:grocery_admin/models/product.dart';
import 'package:grocery_admin/themes/theme_color.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadProduct extends StatefulWidget {
  const UploadProduct({super.key});
  @override
  State<UploadProduct> createState() => _UploadProductState();
}

class _UploadProductState extends State<UploadProduct> {
  File? _pickedImage;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  final uuid = Uuid();
  String productName = '';
  String productDescription = '';
  int productPrice = 0;
  int productDiscount = 0;
  String productCategory = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HashColorCodes.green,
        title: const Text(
          "Upload Product",
          style: TextStyle(
            fontFamily: 'Sarala',
            color: HashColorCodes.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_pickedImage == null)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HashColorCodes.green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),
                  ),
                  onPressed: () {
                    _pickImageFromGallery();
                  },
                  child: const Text('Upload Image',
                      style: TextStyle(color: HashColorCodes.white)),
                ),
              if (_pickedImage != null)
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: Image.file(
                    _pickedImage!,
                    fit: BoxFit.cover,
                  ),
                )
              else
                const Text(
                  'No image selected',
                  style: TextStyle(fontSize: 20),
                ),
              const SizedBox(height: 16.0),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Product Name',
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
                onChanged: (value) {
                  setState(() {
                    productName = value;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              TextField(
                onChanged: (value) {
                  setState(() {
                    productDescription = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Product Description',
                  // labelText: 'Product Name',
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
                  hintText: 'Enter Description',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                onChanged: (value) {
                  setState(() {
                    productCategory = value;
                  });
                },
                decoration: const InputDecoration(
                  // labelText: 'Product Name',
                  labelText: 'Product Category',
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
                  hintText: 'Enter Category',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    productPrice = 0;
                  });
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Product Price',
                  // labelText: 'Product Name',
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
              const SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    productDiscount = 0;
                  });
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Product Discount',
                  // labelText: 'Product Name',
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
                // decoration: const InputDecoration(),
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: HashColorCodes.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 2,
                  ),
                ),
                onPressed: () async {
                  final String fileName = uuid.v4();
                  final Reference storageRef =
                      _storage.ref().child('images/$fileName.jpg');
                  final UploadTask uploadTask =
                      storageRef.putFile(_pickedImage!);
                  final TaskSnapshot snapshot =
                      await uploadTask.whenComplete(() {});
                  final String? downloadUrl =
                      await snapshot.ref.getDownloadURL();
                  if (downloadUrl != null) {
                    Product newProduct = Product(
                      id: uuid.v4(),
                      name: productName,
                      price: productPrice,
                      description: productDescription,
                      imgurl: downloadUrl,
                      discount: productDiscount,
                      category: productCategory,
                      documentId: '',
                    );
                    APIs.uploadProduct(newProduct).then((value) {
                      Dialogs.showSnackbar(context, "Product Added");
                    });
                    setState(() {
                      productName = '';
                      productCategory = '';
                      productDiscount = 0;
                      productDescription = '';
                      productPrice = 0;
                      _pickedImage = null;
                    });
                  }
                },
                child: const Text('Upload Product',
                    style: TextStyle(color: HashColorCodes.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
