import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:law_diary/common.dart';

class UploadProfilePage extends StatefulWidget {
  @override
  _UploadProfilePageState createState() => _UploadProfilePageState();
}

class _UploadProfilePageState extends State<UploadProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _obscureText = true;
  bool isLoading = false;
  XFile? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  _captureImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  _uploadImage() async {
    if (_selectedImage != null) {
      setState(() {
        isLoading = true;
      });
      try {
        XFile file = _selectedImage!;
        Reference ref = FirebaseStorage.instance
            .ref()
            .child("images")
            .child("${DateTime.now().millisecondsSinceEpoch}.jpg");
        print(">>>>>>> ref $ref");

        final metadata = SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {'picked-file-path': file.path},
        );
        print(">>>>>>> metadata $metadata");

        var uploadTask = ref.putData(await file.readAsBytes(), metadata);
        print(">>>>>>> uploadTask $uploadTask");

        await uploadTask.whenComplete(() async {
          var imageURL = await ref.getDownloadURL();
          print("><< image url $imageURL");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile uploaded successfully!')),
          );
        });
      } catch (e) {
        print("Upload failed: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Upload failed. Please try again.')),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a profile picture.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: thirdcolor,
      appBar: AppBar(
        backgroundColor: thirdcolor,
        elevation: 0,
        leading: BackButton(
          color: maincolor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Form(
                  child: Column(
                    children: [
                      Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            GestureDetector(
                              onTap: _pickImage,
                              child: CircleAvatar(
                                radius: 80,
                                backgroundColor: Colors.white,
                                backgroundImage: _selectedImage != null
                                    ? FileImage(File(_selectedImage!.path))
                                    : null,
                                child: _selectedImage == null
                                    ? Icon(
                                        Icons.person,
                                        size: 80,
                                        color: Colors.black,
                                      )
                                    : null,
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: GestureDetector(
                                onTap: _captureImage,
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Email Field
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: btncolor,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: name,
                                border: InputBorder.none,
                              ),
                              controller: _nameController,
                              // validator: (value) {
                              //   return value!.isEmpty
                              //       ? 'Please enter Name'
                              //       : null;
                              // },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: btncolor,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: email,
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: Icon(_obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                              ),
                              controller: _emailController,
                              obscureText: _obscureText,
                              // validator: (value) {
                              //   return value!.isEmpty
                              //       ? 'Please enter Email'
                              //       : null;
                              // },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Submit Button
                      GestureDetector(
                        onTap: () async {
                          _uploadImage();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                            color: btncolor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: const EdgeInsets.only(left: 25, right: 25),
                          child: Center(
                            child: isLoading
                                ? const SpinKitRing(
                                    size: 23,
                                    lineWidth: 3,
                                    color: Colors.black,
                                  )
                                : Text(
                                    'Save',
                                    style: TextStyle(
                                      color: seccolor,
                                      fontSize: 15,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
