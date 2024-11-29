// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:law_diary/common.dart';
import 'package:shared_preferences/shared_preferences.dart';

// const domain = "https://tmm.tastysoft.co";
const domain = "http://192.168.1.17:8080";

class API {
  loginUser(email, password) async {
    final prefs = await SharedPreferences.getInstance();
    // String userid = prefs.getInt("userid").toString();
    try {
      var url = "$domain/lawdiary/users/login";
      var body = jsonEncode({
        // "userid": userid,
        'email': email,
        'password': password,
      });
      print(body);
      print(url);
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );
      return response;
    } catch (error) {
      print(error.toString());
    }
  }

  registerUser(name, email, password) async {
    try {
      var url = "$domain/lawdiary/users/register";
      var body = jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      });
      print(url);
      print(body);
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );
      return response;
    } catch (error) {
      print(error.toString());
    }
  }

  updateUser(email, name, profile, userid) async {
    try {
      var url = "$domain/api/v1/users/$userid";
      var body = jsonEncode({
        'email': email,
        'name': name,
        'profile': profile,
      });
      print(body);
      print(url);
      var response = await http.patch(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );
      return response;
    } catch (error) {
      print(error.toString());
    }
  }

  getAllDiariesApi() async {
    try {
      var response = await http.get(
        Uri.parse("$domain/lawdiary/diaries/getalldiaries/userid/$userid"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      return response;
    } catch (error) {
      print(error.toString());
    }
  }

  getAllDiariesWithCaseNumApi(casenum) async {
    try {
      var response = await http.get(
        Uri.parse(
            "$domain/lawdiary/diaries/getalldiaries/userid/$userid/causenum?causenum=$casenum"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      return response;
    } catch (error) {
      print(error.toString());
    }
  }

  createDiaryApi(
      previousdate, clientname, action, todo, causenum, appointment) async {
    try {
      var url = "$domain/lawdiary/diaries/creatediray";
      var body = jsonEncode({
        "userid": userid,
        "previousdate": previousdate,
        "clientname": clientname,
        "action": action,
        "todo": todo,
        "causenum": causenum,
        "appointment": appointment,
      });
      print("++++++++++--------- $body");
      print(">>>>>>>>>>> create diary url $url");
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );
      print("00000000000${response.body}");
      return response;
    } catch (error) {
      print(
        error.toString(),
      );
    }
  }

  editDiaryApi(id, clientname, action, todo, causenum, appointment) async {
    try {
      var url = "$domain/lawdiary/diaries/updatediary/$id";
      var body = jsonEncode({
        "clientname": clientname,
        "action": action,
        "todo": todo,
        "causenum": causenum,
        "appointment": appointment,
      });
      var response = await http.patch(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );
      print("00000000000${response.body}");
      return response;
    } catch (error) {
      print(error.toString());
    }
  }

  createDiaryDetailsApi(diaryId, startDate, appointment, actions, toDo, notes,
      pdffile, fcmtoken) async {
    try {
      var url = "$domain/api/v1/details";
      var body = jsonEncode({
        "diaryId": diaryId,
        "startDate": startDate,
        "appointment": appointment,
        "actions": actions,
        "toDo": toDo,
        "notes": notes,
        "url": pdffile,
      });
      print(">>>>>>>>>>> create diary details url $url");
      print('>>>>>>>>>>>details body${body}');
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );
      return response;
    } catch (error) {
      print(
        error.toString(),
      );
    }
  }

  // editDiaryApi(
  //   id,
  //   caseNum,
  //   Case,
  //   startDate,
  //   appointment,
  //   actions,
  //   toDo,
  //   notes,
  // ) async {
  //   try {
  //     var url = "$domain/api/v1/diaries/$id";
  //     var body = jsonEncode({
  //       "caseNum": caseNum,
  //       "Case": Case,
  //       "startDate": startDate,
  //       "appointment": appointment,
  //       "actions": actions,
  //       "toDo": toDo,
  //       "notes": notes
  //     });
  //     print(">>>>>>>>>>> update diary url $url");
  //     var response = await http.patch(
  //       Uri.parse(url),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'Authorization': 'Bearer $token',
  //       },
  //       body: body,
  //     );
  //     return response;
  //   } catch (error) {
  //     print(error.toString());
  //   }
  // }

  deleteDiaryApi(id) async {
    try {
      var url = "$domain/lawdiary/diaries/deletediary/$id";
      var response = await http.delete(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      return response;
    } catch (error) {
      print(error.toString());
    }
  }

  getAllNotesApi(categoryId) async {
    try {
      var response = await http.get(
        Uri.parse("$domain/api/v1/notes/userid/$userid/categoryId/$categoryId"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);
      return response;
    } catch (error) {
      print(error.toString());
    }
  }

  createNoteApi(categoryId, title, notes, attachment) async {
    try {
      var url = "$domain/api/v1/notes";
      var body = jsonEncode({
        "userid": userid,
        "categoryId": categoryId,
        "title": title,
        "notes": notes,
        "attachment": attachment,
      });
      print(">>>>>>>>>>> create note url $url");
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );
      return response;
    } catch (error) {
      print(
        error.toString(),
      );
    }
  }

  deleteNoteApi(id) async {
    try {
      var url = "$domain/api/v1/notes/$id";
      var response = await http.delete(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      return response;
    } catch (error) {
      print(error.toString());
    }
  }

  editNoteApi(
    noteId,
    title,
    notes,
  ) async {
    try {
      var url = "$domain/api/v1/notes/$userid/$noteId";
      var body = jsonEncode({"title": "$title", "notes": "$notes"});

      print(">>>>>>>>>>> update note url $url");
      var response = await http.patch(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );
      return response;
    } catch (error) {
      print(error.toString());
    }
  }

  getAllNotesCategoryApi() async {
    print(">>>>> user id $userid");
    try {
      var response = await http.get(
        Uri.parse("$domain/api/v1/note-categories/userid/$userid"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);
      return response;
    } catch (error) {
      print(error.toString());
    }
  }

  createNoteCategoryApi(categoryName) async {
    try {
      var url = "$domain/api/v1/note-categories";
      var body = jsonEncode({
        "userid": userid,
        "categoryName": categoryName,
      });
      print(">>>>>>>>>>> create notecategory url $url");
      print(token);
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );
      return response;
    } catch (error) {
      print(
        error.toString(),
      );
    }
  }

  deleteNoteCategoryApi(id) async {
    try {
      var url = "$domain/api/v1/note-categories/$id";
      var response = await http.delete(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      return response;
    } catch (error) {
      print(error.toString());
    }
  }

  editNoteCategoryApi(
    id,
    categoryName,
  ) async {
    try {
      var url = "$domain/api/v1/note-categories/$userid/$id";
      var body = jsonEncode({"categoryName": "$categoryName"});
      print(">>>>>>>>>>> update note category url $url");
      var response = await http.patch(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );
      return response;
    } catch (error) {
      print(error.toString());
    }
  }

  getAllLawCategoriesApi() async {
    try {
      var response = await http.get(
        Uri.parse("$domain/api/v1/law-categories"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);
      return response;
    } catch (error) {
      print(error.toString());
    }
  }

  createLawCategoryApi(categoryName, categoryDesc) async {
    try {
      var url = "$domain/api/v1/law-categories";
      var body = jsonEncode({
        "categoryName": categoryName,
        "categoryDesc": categoryDesc,
      });
      print(">>>>>>>>>>> create lawcategory url $url");
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );
      return response;
    } catch (error) {
      print(
        error.toString(),
      );
    }
  }

  deleteLawCategoryApi(id) async {
    try {
      var url = "$domain/api/v1/law-categories/$id";
      var response = await http.delete(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      return response;
    } catch (error) {
      print(error.toString());
    }
  }

  editLawCategoryApi(
    id,
    categoryName,
    categoryDesc,
  ) async {
    try {
      var url = "$domain/api/v1/law-categories/$id";
      var body = jsonEncode(
          {"categoryName": "$categoryName", "categoryDesc": categoryDesc});
      print(">>>>>>>>>>> update law category url $url");
      var response = await http.patch(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );
      return response;
    } catch (error) {
      print(error.toString());
    }
  }

  editDetailsDiaryApi(
    detailsId,
    diaryId,
    startDate,
    appointment,
    actions,
    toDo,
    notes,
  ) async {
    try {
      print('details id >>>>>>>>>>>${detailsId}');
      var url = "$domain/api/v1/details/$detailsId";
      var body = jsonEncode({
        "diaryId": diaryId,
        "startDate": startDate,
        "appointment": appointment,
        "actions": actions,
        "toDo": toDo,
        "notes": notes
      });
      print(">>>>>>>>>>> update diary url $url");
      print(">>>>>>>>>>> update diary body $body");
      var response = await http.patch(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );
      return response;
    } catch (error) {
      print(error.toString());
    }
  }

  getAttachmentApi() async {
    try {
      var response = await http.get(
        Uri.parse("$domain/api/v1/attachment"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);
      return response;
    } catch (error) {
      print(error.toString());
    }
  }

  createAttachmentApi(attachmentName, attachmentFile) async {
    try {
      var url = "$domain/api/v1/attachment";
      var body = jsonEncode({
        "attachmentName": attachmentName,
        "attachmentFile": attachmentFile,
      });
      print(">>>>>>>>>>> create attachment url $url");
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );
      return response;
    } catch (error) {
      print(
        error.toString(),
      );
    }
  }

  getAttachmentDetailsApi(file) async {
    try {
      var response = await http.get(
        Uri.parse("$domain/uploads/$file"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);
      return response;
    } catch (error) {
      print(error.toString());
    }
  }

  editAttachmentApi(
    id,
    attachmentName,
  ) async {
    try {
      var url = "$domain/api/v1/attachment/$id";
      var body = jsonEncode({
        "attachmentName": attachmentName,
      });
      print(">>>>>>>>>>> update attachment url $url");
      var response = await http.patch(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );
      return response;
    } catch (error) {
      print(error.toString());
    }
  }

  logoutUser(userid) async {
    try {
      var url = "$domain/lawdiary/users/logout";
      var body = jsonEncode({
        'userid': userid,
      });
      print(body);
      print(url);
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );
      return response;
    } catch (error) {
      print(error.toString());
    }
  }

  changePsw(email, oldpassword, newpassword) async {
    try {
      var url = "$domain/api/v1/users/changepassword";
      var body = jsonEncode({
        'email': email,
        'oldPassword': oldpassword,
        'newPassword': newpassword,
      });
      print(body);
      print(url);
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );
      return response;
    } catch (error) {
      print(error.toString());
    }
  }

  forgotPsw(email, userid) async {
    try {
      var url = "$domain/api/v1/users/forgotPassword";
      var body = jsonEncode({
        'email': email,
        'userid': userid,
      });
      print(body);
      print(url);
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );
      return response;
    } catch (error) {
      print(error.toString());
    }
  }

  verify(email, otp) async {
    try {
      var url = "$domain/api/v1/users/forgotPassword/emailverify";
      var body = jsonEncode({
        'email': email,
        'otp': otp,
      });
      print(body);
      print(url);
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );
      return response;
    } catch (error) {
      print(error.toString());
    }
  }

  setNewPws(email, otp, newPassword) async {
    try {
      var url = "$domain/api/v1/users/forgotPassword/updatedpassword";
      var body =
          jsonEncode({'email': email, 'otp': otp, "newPassword": newPassword});
      print(body);
      print(url);
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );
      return response;
    } catch (error) {
      print(error.toString());
    }
  }

  getDefaultCategoryApi() async {
    try {
      var response = await http.get(
        Uri.parse("$domain/api/v1/note-categories/defcategories?default=true"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);
      return response;
    } catch (error) {
      print(error.toString());
    }
  }

  getAllBooks() async {
    try {
      var response = await http.get(
        Uri.parse("$domain/lawdiary/lawbooks/getallbooks/userid/$userid"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      return response;
    } catch (error) {
      print(error.toString());
    }
  }

  createTitle(title) async {
    try {
      var url = "$domain/lawdiary/lawbooks/createtitle";
      var body = jsonEncode({
        "userid": userid,
        "title": title,
      });
      print("++++++++++--------- $body");
      print(">>>>>>>>>>> create diary url $url");
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );
      print("00000000000${response.body}");
      return response;
    } catch (error) {
      print(
        error.toString(),
      );
    }
  }

  editTitle(bookid, title) async {
    try {
      var url = "$domain/lawdiary/lawbooks/updatetitle/$bookid";
      var body = jsonEncode({"title": "$title"});

      print(">>>>>>>>>>> update note url $url");
      var response = await http.patch(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );
      return response;
    } catch (error) {
      print(error.toString());
    }
  }

  deleteTitle(bookid) async {
    try {
      var url = "$domain/lawdiary/lawbooks/deletetitle/$bookid";
      var response = await http.delete(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      return response;
    } catch (error) {
      print(error.toString());
    }
  }

  createSection(bookid, sectionname) async {
    try {
      var url = "$domain/lawdiary/lawbooks/createsection";
      var body = jsonEncode({
        "bookid": bookid,
        "sectionname": sectionname,
      });
      print("++++++++++--------- $body");
      print(">>>>>>>>>>> create diary url $url");
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );
      print("00000000000${response.body}");
      return response;
    } catch (error) {
      print(
        error.toString(),
      );
    }
  }

  editSection(bookid, title) async {
    try {
      var url = "$domain/lawdiary/lawbooks/updatetitle/$bookid";
      var body = jsonEncode({"title": "$title"});

      print(">>>>>>>>>>> update note url $url");
      var response = await http.patch(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );
      return response;
    } catch (error) {
      print(error.toString());
    }
  }

  deleteSection(bookid) async {
    try {
      var url = "$domain/lawdiary/lawbooks/deletetitle/$bookid";
      var response = await http.delete(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      return response;
    } catch (error) {
      print(error.toString());
    }
  }

  createSubSection(bookid, sectionname) async {
    try {
      var url = "$domain/lawdiary/lawbooks/createsection";
      var body = jsonEncode({
        "bookid": bookid,
        "sectionname": sectionname,
      });
      print("++++++++++--------- $body");
      print(">>>>>>>>>>> create diary url $url");
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );
      print("00000000000${response.body}");
      return response;
    } catch (error) {
      print(
        error.toString(),
      );
    }
  }

  editSubSection(bookid, title) async {
    try {
      var url = "$domain/lawdiary/lawbooks/updatetitle/$bookid";
      var body = jsonEncode({"title": "$title"});

      print(">>>>>>>>>>> update note url $url");
      var response = await http.patch(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );
      return response;
    } catch (error) {
      print(error.toString());
    }
  }

  deleteSubSection(bookid) async {
    try {
      var url = "$domain/lawdiary/lawbooks/deletetitle/$bookid";
      var response = await http.delete(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      return response;
    } catch (error) {
      print(error.toString());
    }
  }
}
