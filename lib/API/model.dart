import 'package:flutter/material.dart';
import 'dart:convert';

class diarylistmodel {
  String diaryid;
  String clientname;
  String previousdate;
  String action;
  String todo;
  String causenum;
  String appointment;

  diarylistmodel({
    required this.diaryid,
    required this.clientname,
    required this.previousdate,
    required this.action,
    required this.todo,
    required this.causenum,
    required this.appointment,
  });

  factory diarylistmodel.fromJson(Map<String, dynamic> jsonData) {
    return diarylistmodel(
      diaryid: jsonData['diaryid'],
      // categoryId: jsonData['categoryId'],
      clientname: jsonData['clientname'],
      previousdate: jsonData['previousdate'],
      action: jsonData['action'],
      todo: jsonData['todo'],
      causenum: jsonData['causenum'],
      appointment: jsonData['appointment'],
    );
  }

  static Map<String, dynamic> toMap(diarylistmodel music) => {
        'diaryid': music.diaryid,
        // 'categoryId': music.categoryId,
        'clientname': music.clientname,
        'previousdate': music.previousdate,
        'action': music.action,
        'todo': music.todo,
        'causenum': music.causenum,
        'appointment': music.appointment,
      };

  static String encode(List<diarylistmodel> diaries) => json.encode(
        diaries
            .map<Map<String, dynamic>>(
                (eachdiary) => diarylistmodel.toMap(eachdiary))
            .toList(),
      );

  static List<diarylistmodel> decode(String diaries) => (json.decode(diaries)
          as List<dynamic>)
      .map<diarylistmodel>((eachdiary) => diarylistmodel.fromJson(eachdiary))
      .toList();

  static String sigleencode(diarylistmodel single) =>
      json.encode(diarylistmodel.toMap(single));
  static diarylistmodel singledecode(dynamic single) =>
      diarylistmodel.fromJson(json.decode(single));
}

class booklistmodel {
  String bookid;
  String title;
  String createdAt;
  String updatedAt;
  booklistmodel({
    required this.bookid,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  factory booklistmodel.fromJson(Map<String, dynamic> jsonData) {
    return booklistmodel(
      bookid: jsonData['bookid'],
      title: jsonData['title'],
      createdAt: jsonData['createdAt'],
      updatedAt: jsonData['updatedAt'],
    );
  }

  static Map<String, dynamic> toMap(booklistmodel book) => {
        'bookid': book.bookid,
        'title': book.title,
        'createdAt': book.createdAt,
        'updatedAt': book.updatedAt,
      };

  static String encode(List<booklistmodel> details) => json.encode(
        details
            .map<Map<String, dynamic>>(
                (eachdetails) => booklistmodel.toMap(eachdetails))
            .toList(),
      );

  static List<booklistmodel> decode(String details) =>
      (json.decode(details) as List<dynamic>)
          .map<booklistmodel>(
              (eachdetails) => booklistmodel.fromJson(eachdetails))
          .toList();

  static String sigleencode(booklistmodel single) =>
      json.encode(booklistmodel.toMap(single));
  static diarylistmodel singledecode(dynamic single) =>
      diarylistmodel.fromJson(json.decode(single));
}

class sectionlistmodel {
  late String sectionid;
  late String sectionname;
  late String createdAt;
  late String updatedAt;
  sectionlistmodel({
    required this.sectionid,
    required this.sectionname,
    required this.createdAt,
    required this.updatedAt,
  });

  factory sectionlistmodel.fromJson(Map<String, dynamic> jsonData) {
    return sectionlistmodel(
      sectionid: jsonData['sectionid'],
      sectionname: jsonData['sectionname'],
      createdAt: jsonData['createdAt'],
      updatedAt: jsonData['updatedAt'], 
    );
  }

  static Map<String, dynamic> toMap(sectionlistmodel book) => {
        'sectionid': book.sectionid,
        'sectionname': book.sectionname,
        'createdAt': book.createdAt,
        'updatedAt': book.updatedAt,
      };

  static String encode(List<sectionlistmodel> details) => json.encode(
        details
            .map<Map<String, dynamic>>(
                (eachdetails) => sectionlistmodel.toMap(eachdetails))
            .toList(),
      );

  static List<sectionlistmodel> decode(String details) =>
      (json.decode(details) as List<dynamic>)
          .map<sectionlistmodel>(
              (eachdetails) => sectionlistmodel.fromJson(eachdetails))
          .toList();

  static String sigleencode(sectionlistmodel single) =>
      json.encode(sectionlistmodel.toMap(single));
  static diarylistmodel singledecode(dynamic single) =>
      diarylistmodel.fromJson(json.decode(single));
}


class notelistmodel {
  String categoryId;
  String noteId;
  String title;
  String notes;
  String? attachment;

  notelistmodel({
    required this.categoryId,
    required this.noteId,
    required this.title,
    required this.notes,
    required this.attachment,
  });

  factory notelistmodel.fromJson(Map<String, dynamic> jsonData) {
    return notelistmodel(
      categoryId: jsonData['categoryid'],
      noteId: jsonData['noteId'],
      title: jsonData['title'],
      notes: jsonData['notes'],
      attachment: jsonData['attachment'],
    );
  }

  static Map<String, dynamic> toMap(notelistmodel music) => {
        'categoryId': music.categoryId,
        'noteId': music.noteId,
        'title': music.title,
        'notes': music.notes,
        'attachment': music.attachment,
      };

  static String encode(List<notelistmodel> notes) => json.encode(
        notes
            .map<Map<String, dynamic>>(
                (eachnote) => notelistmodel.toMap(eachnote))
            .toList(),
      );

  static List<notelistmodel> decode(String notes) =>
      (json.decode(notes) as List<dynamic>)
          .map<notelistmodel>((eachnote) => notelistmodel.fromJson(eachnote))
          .toList();

  static String sigleencode(notelistmodel single) =>
      json.encode(notelistmodel.toMap(single));
  static notelistmodel singledecode(dynamic single) =>
      notelistmodel.fromJson(json.decode(single));
}

class notecategorylistmodel {
  String categoryId;
  String categoryName;

  notecategorylistmodel({
    required this.categoryId,
    required this.categoryName,
  });

  factory notecategorylistmodel.fromJson(Map<String, dynamic> jsonData) {
    return notecategorylistmodel(
      categoryId: jsonData['categoryId'],
      categoryName: jsonData['categoryName'],
    );
  }

  static Map<String, dynamic> toMap(notecategorylistmodel music) => {
        'categoryId': music.categoryId,
        'categoryName': music.categoryName,
      };

  static String encode(List<notecategorylistmodel> notes) => json.encode(
        notes
            .map<Map<String, dynamic>>((eachnotecategory) =>
                notecategorylistmodel.toMap(eachnotecategory))
            .toList(),
      );

  static List<notecategorylistmodel> decode(String notecategories) =>
      (json.decode(notecategories) as List<dynamic>)
          .map<notecategorylistmodel>((eachnotecategory) =>
              notecategorylistmodel.fromJson(eachnotecategory))
          .toList();

  static String sigleencode(notecategorylistmodel single) =>
      json.encode(notecategorylistmodel.toMap(single));
  static notecategorylistmodel singledecode(dynamic single) =>
      notecategorylistmodel.fromJson(json.decode(single));
}

class lawcategorylistmodel {
  String categoryId;
  String categoryName;
  String categoryDesc;

  lawcategorylistmodel({
    required this.categoryId,
    required this.categoryName,
    required this.categoryDesc,
  });

  factory lawcategorylistmodel.fromJson(Map<String, dynamic> jsonData) {
    return lawcategorylistmodel(
      categoryId: jsonData['categoryId'],
      categoryName: jsonData['categoryName'],
      categoryDesc: jsonData['categoryDesc'],
    );
  }

  static Map<String, dynamic> toMap(lawcategorylistmodel music) => {
        'categoryId': music.categoryId,
        'categoryName': music.categoryName,
        'categoryDesc': music.categoryDesc,
      };

  static String encode(List<lawcategorylistmodel> notes) => json.encode(
        notes
            .map<Map<String, dynamic>>((eachlawcategory) =>
                lawcategorylistmodel.toMap(eachlawcategory))
            .toList(),
      );

  static List<lawcategorylistmodel> decode(String lawcategories) =>
      (json.decode(lawcategories) as List<dynamic>)
          .map<lawcategorylistmodel>((eachlawcategory) =>
              lawcategorylistmodel.fromJson(eachlawcategory))
          .toList();

  static String sigleencode(lawcategorylistmodel single) =>
      json.encode(lawcategorylistmodel.toMap(single));
  static lawcategorylistmodel singledecode(dynamic single) =>
      lawcategorylistmodel.fromJson(json.decode(single));
}

class attachmentlistmodel {
  String attachmentId;
  String attachmentName;
  String attachmentFile;

  attachmentlistmodel({
    required this.attachmentId,
    required this.attachmentName,
    required this.attachmentFile,
  });

  factory attachmentlistmodel.fromJson(Map<String, dynamic> jsonData) {
    return attachmentlistmodel(
      attachmentId: jsonData['attachmentId'],
      attachmentName: jsonData['attachmentName'],
      attachmentFile: jsonData['attachmentFile'],
    );
  }

  static Map<String, dynamic> toMap(attachmentlistmodel music) => {
        'attachmentId': music.attachmentId,
        'attachmentName': music.attachmentName,
        'attachmentFile': music.attachmentFile,
      };

  static String encode(List<attachmentlistmodel> attachments) => json.encode(
        attachments
            .map<Map<String, dynamic>>(
                (eachattachment) => attachmentlistmodel.toMap(eachattachment))
            .toList(),
      );

  static List<attachmentlistmodel> decode(String attachments) =>
      (json.decode(attachments) as List<dynamic>)
          .map<attachmentlistmodel>(
              (eachattachment) => attachmentlistmodel.fromJson(eachattachment))
          .toList();

  static String sigleencode(attachmentlistmodel single) =>
      json.encode(attachmentlistmodel.toMap(single));
  static attachmentlistmodel singledecode(dynamic single) =>
      attachmentlistmodel.fromJson(json.decode(single));
}
