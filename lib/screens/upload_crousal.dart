import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:grocery_admin/api/apis.dart';
import 'package:grocery_admin/common/dialogs.dart';
import 'package:grocery_admin/models/banner.dart';
import 'package:grocery_admin/screens/homescreen.dart';
import 'package:grocery_admin/themes/theme_color.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class UploadCrousal extends StatefulWidget {
  const UploadCrousal({super.key});
  @override
  State<UploadCrousal> createState() => _UploadCrousalState();
}

class _UploadCrousalState extends State<UploadCrousal> {
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
        backgroundColor: Colors.green,
        title: const Text(
          "Upload Crousal",
          style: TextStyle(
            fontFamily: 'Sarala',
            color: Colors.white,
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
                  child: const Text(
                    'Upload Image',
                    style: TextStyle(color: HashColorCodes.white),
                  ),
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
                onChanged: (value) {
                  setState(() {
                    productName = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                ),
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
                ),
              ),
              const SizedBox(height: 16.0),
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
                      _storage.ref().child('banner/$fileName.jpg');
                  final UploadTask uploadTask =
                      storageRef.putFile(_pickedImage!);
                  final TaskSnapshot snapshot =
                      await uploadTask.whenComplete(() {});
                  final String? downloadUrl =
                      await snapshot.ref.getDownloadURL();
                  if (downloadUrl != null) {
                    Carousal newBanner = Carousal(
                      id: uuid.v4(),
                      title: productName,
                      description: productDescription,
                      imgUrl: downloadUrl,
                      redirectUrl: '',
                      documentId: '',
                    );
                    APIs.uploadBanner(newBanner).then((value) {
                      Dialogs.showSnackbar(context, "Crousal Added");
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => HomeScreen()));
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
                child: const Text(
                  'Upload Crousal ',
                  style: TextStyle(color: HashColorCodes.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
