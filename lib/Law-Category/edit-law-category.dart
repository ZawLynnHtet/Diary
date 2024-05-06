import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:law_diary/API/api.dart';
import 'package:law_diary/Law-Category/create-law-category.dart';
import 'package:law_diary/common.dart';

class EditLawCategory extends StatefulWidget {
  String editData;
  EditLawCategory({super.key, required this.editData});

  @override
  State<EditLawCategory> createState() => _EditLawCategoryState();
}

class _EditLawCategoryState extends State<EditLawCategory> {
  final TextEditingController _categorynameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool isLoading = false;
  var editData;

  initData() {
    print(">>>>>> editdata");
    editData = jsonDecode(widget.editData);
    print(">>>>>>>>>>>> edit data $editData");

    setState(() {
      if (editData != null) {
        _categorynameController.text = editData["categoryName"] ?? '';
        _descriptionController.text = editData["categoryDesc"] ?? '';
      }
    });
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maincolor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: maincolor,
        iconTheme: IconThemeData(
          color: seccolor,
          size: 30,
        ),
        title: Text(
          "Update Category",
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: seccolor,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(
              right: 15,
              bottom: 10,
              left: 15,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    hintText: 'Enter Category Name',
                    border: InputBorder.none,
                  ),
                  controller: _categorynameController,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 15,
              bottom: 10,
              left: 15,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    hintText: 'Enter Description',
                    border: InputBorder.none,
                  ),
                  controller: _descriptionController,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 30,
              height: MediaQuery.of(context).size.height * 0.06,
              child: MaterialButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                color: darkmain,
                onPressed: () {
                  if (_categorynameController.text.isEmpty) {
                    showToast(
                        context, 'Please Enter Category Name!!', Colors.red);
                  } else if (_descriptionController.text.isEmpty) {
                    showToast(
                        context, 'Please Enter Description!!', Colors.red);
                  } else {
                    updateLawCategory();
                  }
                },
                child: isLoading
                    ? const SpinKitRing(
                        size: 23,
                        lineWidth: 3,
                        color: Colors.black,
                      )
                    : Text(
                        'Update',
                        style: GoogleFonts.poppins(
                            color: maincolor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  updateLawCategory() async {
    print(">>>>>>>>>>> name");
    print(_categorynameController.text);
    isLoading = true;
    final response = await API().editLawCategoryApi(
      editData["categoryId"].toString(),
      _categorynameController.text,
      _descriptionController.text,
    );
    print("hererere");
    var res = jsonDecode(response.body);
    print(
        ">>>>>>>>>>> edit law category response statusCode ${response.statusCode}");
    print(">>>>>>>>>>> edit law category response body ${response.body}");
    if (response.statusCode == 200) {
      print("herer 0--");
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CreateLawCategory(),
        ),
      );
    } else if (response.statusCode == 400) {
      showToast(context, res['message'], Colors.red);
    }
    setState(() {
      isLoading = false;
    });
  }
}
