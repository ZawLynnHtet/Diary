import 'package:flutter/material.dart';
import 'dart:convert';

class diarylistmodel {
  String diaryId;
  String clientName;
  String cause;
  String causeNum;
  String causeType;

  diarylistmodel({
    required this.diaryId,
    required this.clientName,
    required this.cause,
    required this.causeNum,
    required this.causeType,
  });

  factory diarylistmodel.fromJson(Map<String, dynamic> jsonData) {
    return diarylistmodel(
        diaryId: jsonData['diaryId'],
        // categoryId: jsonData['categoryId'],
        clientName: jsonData['clientName'],
        cause: jsonData['cause'],
        causeNum: jsonData['causeNum'],
        causeType: jsonData['causeType']);
  }

  static Map<String, dynamic> toMap(diarylistmodel music) => {
        'diaryId': music.diaryId,
        // 'categoryId': music.categoryId,
        'clientName': music.clientName,
        'cause': music.cause,
        'causeNum': music.causeNum,
        'causeType': music.causeType,
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

class diarydetailslistmodel {
  String detailsId;
  String diaryId;
  String actions;
  String toDo;
  String notes;
  String startDate;
  String appointment;

  diarydetailslistmodel({
    required this.detailsId,
    required this.diaryId,
    required this.actions,
    required this.toDo,
    required this.notes,
    required this.startDate,
    required this.appointment,
  });

  factory diarydetailslistmodel.fromJson(Map<String, dynamic> jsonData) {
    return diarydetailslistmodel(
        detailsId: jsonData['detailsId'],
        diaryId: jsonData['diaryId'],
        actions: jsonData['actions'],
        toDo: jsonData['toDo'],
        notes: jsonData['notes'],
        startDate: jsonData['startDate'],
        appointment: jsonData['appointment']);
  }

  static Map<String, dynamic> toMap(diarydetailslistmodel music) => {
        'detailsId': music.diaryId,
        'diaryId': music.diaryId,
        'actions': music.actions,
        'toDo': music.toDo,
        'notes': music.notes,
        'startDate': music.startDate,
        'appointmentdate': music.appointment,
      };

  static String encode(List<diarydetailslistmodel> details) => json.encode(
        details
            .map<Map<String, dynamic>>(
                (eachdetails) => diarydetailslistmodel.toMap(eachdetails))
            .toList(),
      );

  static List<diarydetailslistmodel> decode(String details) =>
      (json.decode(details) as List<dynamic>)
          .map<diarydetailslistmodel>(
              (eachdetails) => diarydetailslistmodel.fromJson(eachdetails))
          .toList();

  static String sigleencode(diarydetailslistmodel single) =>
      json.encode(diarydetailslistmodel.toMap(single));
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
          .map<attachmentlistmodel>((eachattachment) =>
              attachmentlistmodel.fromJson(eachattachment))
          .toList();

  static String sigleencode(attachmentlistmodel single) =>
      json.encode(attachmentlistmodel.toMap(single));
  static attachmentlistmodel singledecode(dynamic single) =>
      attachmentlistmodel.fromJson(json.decode(single));
}
