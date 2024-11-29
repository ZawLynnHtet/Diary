import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:law_diary/common.dart';
import 'package:law_diary/localization/locales.dart';

class DetailsPage extends StatefulWidget {
  final item;
  DetailsPage({required this.item});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  var _subsection;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  final now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _subsection = widget.item;
    print(_subsection);
    if (_subsection != null) {
      _titleController.text = _subsection['subsectionname'];
      _contentController.text = _subsection['description'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: maincolor,
        appBar: AppBar(
          backgroundColor: maincolor,
          elevation: 0,
          leading: BackButton(
            color: darkmain,
            onPressed: () {
              Navigator.pop(
                context,
              );
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleData.bookTitle.getString(context),
                style: TextStyle(
                    color: darkmain, fontSize: 18, fontWeight: FontWeight.w600),
              ),
              TextField(
                controller: _titleController,
                maxLines: null,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: LocaleData.bookTitle.getString(context),
                    hintStyle: TextStyle(
                        color: Colors.black26,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5)),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                LocaleData.note.getString(context),
                style: TextStyle(
                    color: darkmain, fontSize: 18, fontWeight: FontWeight.w600),
              ),
              TextField(
                controller: _contentController,
                maxLines: null,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: LocaleData.type.getString(context),
                    hintStyle: TextStyle(
                        color: Colors.black26,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.5)),
              ),
              Text(
                LocaleData.attachment.getString(context),
                style: TextStyle(
                    color: darkmain, fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
