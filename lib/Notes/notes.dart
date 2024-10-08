import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:law_diary/API/api.dart';
import 'package:law_diary/API/model.dart';
import 'package:law_diary/Note-Category/note-category.dart';
import 'package:law_diary/Notes/create_notes.dart';
import 'package:law_diary/Notes/edit_note.dart';
import 'package:law_diary/common.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesScreen extends StatefulWidget {
  final String categoryId;
  const NotesScreen({super.key, required this.categoryId});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<notelistmodel> mynote = [];
  notelistmodel? selectednote;

  bool ready = false;
  bool isLoading = false;

  getnote() async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await API().getAllNotesApi(widget.categoryId);
    final res = jsonDecode(response.body);
    print('>>>>>>>>>>>>>>>>>>>>>>$response');
    if (response.statusCode == 200) {
      List noteList = res['data'];
      print('>>>>>>>>>>>>>>> note list$noteList');
      if (noteList.isNotEmpty) {
        for (var i = 0; i < noteList.length; i++) {
          setState(
            () {
              mynote.add(
                notelistmodel(
                  categoryId: noteList[i]['categoryId'].toString(),
                  noteId: noteList[i]['noteId'],
                  title: noteList[i]['title'],
                  notes: noteList[i]["notes"].toString(),
                  attachment: noteList[i]["attachment"],
                ),
              );
            },
          );
        }
      } else if (response.statusCode == 400) {
        setState(() {
          mynote = [];
        });

        showToast(context, res['message'], Colors.red);
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getnote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: thirdcolor,
      appBar: AppBar(
        backgroundColor: thirdcolor,
        elevation: 0,
        leading: BackButton(
          color: darkmain,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NoteCategoryScreen(),
              ),
            );
          },
        ),
        title: Text(
          'မှတ်ချက်',
          style: GoogleFonts.poppins(
            fontSize: 17,
            color: darkmain,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isLoading
          ? SpinKitRing(
              size: 23,
              lineWidth: 3,
              color: maincolor,
            )
          : mynote.isEmpty
              ? Center(
                  child: Text(
                  "Empty",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: fifthcolor,
                  ),
                ))
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Container(
                      color: Colors.transparent,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        itemCount: mynote.length,
                        itemBuilder: (context, i) {
                          return NoteModel(
                            eachnote: mynote[i],
                          );
                        },
                      ),
                    ),
                  ),
                ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: darkmain,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateNote(
                categoryId: widget.categoryId,
              ),
            ),
          );
        },
        label: Text(
          'Add',
          style: GoogleFonts.poppins(color: seccolor),
        ),
        icon: Icon(
          Icons.add,
          color: seccolor,
        ),
      ),
    );
  }
}

class NoteModel extends StatefulWidget {
  final notelistmodel eachnote;
  const NoteModel({super.key, required this.eachnote});

  @override
  State<NoteModel> createState() => _NoteModelState();
}

class _NoteModelState extends State<NoteModel> {
  List<notelistmodel> mynote = [];
  bool isLoading = false;
  PopupMenuItem _buildPopupMenuItem(String title, int position) {
    return PopupMenuItem(
      value: position,
      child: Row(
        children: [
          Text(title),
        ],
      ),
    );
  }

  _popUpWidget(notelistmodel data) {
    return PopupMenuButton(
      icon: const Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      onSelected: (value) {
        print("value : $value");
        setState(() {});
        if (value == 0) {
          print(">>>>> my data");
          var mydata = jsonEncode({
            "noteId": widget.eachnote.noteId,
            "title": widget.eachnote.title,
            "notes": widget.eachnote.notes,
          });
          print(">>>>> my data");
          print(mydata);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditNote(
                editData: mydata,
                categoryId: widget.eachnote.categoryId,
              ),
            ),
          );
        } else if (value == 1) {
          print(">>>><<<<");
          print(data.noteId);
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'No',
                    style: GoogleFonts.poppins(fontSize: 15),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    deleteNote(data.noteId);
                    setState(() {});
                  },
                  child: isLoading
                      ? const SpinKitDoubleBounce(
                          color: Colors.white,
                          size: 15.0,
                        )
                      : Text(
                          'Yes',
                          style: GoogleFonts.poppins(
                              fontSize: 15, color: Colors.red),
                        ),
                ),
              ],
              title: Text(
                'Are you sure to Delete?',
                style: GoogleFonts.poppins(fontSize: 16),
              ),
              contentPadding: const EdgeInsets.all(2.0),
            ),
          );
        } else {
          print("value >>>> : $value");
        }
      },
      offset: Offset(
        0.0,
        AppBar().preferredSize.height,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      itemBuilder: (contex) => [
        _buildPopupMenuItem(
          'Edit',
          0,
        ),
        _buildPopupMenuItem(
          'Delete',
          1,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {},
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Card(
            elevation: 5,
            color: fourthcolor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: ('${widget.eachnote.attachment}'),
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.eachnote.title,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: backcolor,
                        ),
                      ),
                    ),
                    _popUpWidget(widget.eachnote),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.eachnote.notes,
                    style: GoogleFonts.poppins(fontSize: 16, color: backcolor),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  deleteNote(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await API().deleteNoteApi(id);
    var res = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (res['status'] == 'success') {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotesScreen(
              categoryId: widget.eachnote.categoryId,
            ),
          ),
        );
      }
      showToast(context, res['message'], Colors.green);
    } else if (response.statusCode == 400) {
      Navigator.pop(context);
      showToast(context, res['message'], Colors.red);
    }
    //  Navigator.pop(context);
    //   showToast('${result['returncode']}', 'red');
    setState(() {});
  }
}
