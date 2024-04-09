import 'dart:convert';

import 'package:http/http.dart' as http;

const domain = "https://tmm.tastysoft.co";
String token = "";

class API {
  loginUser(email, password) async {
    try {
      var url = "$domain/api/v1/users/login";
      var body = jsonEncode({
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
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        token = res["token"];
      }
      return response;
    } catch (error) {
      print(error.toString());
    }
  }

  registerUser(name, email, phone, password) async {
    try {
      var url = "$domain/api/v1/users/register";
      var body = jsonEncode({
        'name': name,
        'email': email,
        'phone': phone,
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

  getAllDiariesApi(String userId) async {
    try {
      var response = await http.get(
        Uri.parse("$domain/api/v1/diaries/userid/$userId"),
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

  getSingleDiariesApi(String diaryId) async {
    try {
      var response = await http.get(
        Uri.parse("$domain/api/v1/diaries/$diaryId"),
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

  getdiarydetails(String diaryId) async {
    try {
      String url = "$domain/api/v1/details/diaryId/$diaryId";
      var response = await http.get(
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

  createDiaryApi(userId,causeNum, cause, clientName, causeType,) async {
    try {
      var url = "$domain/api/v1/diaries";
      var body = jsonEncode({
        "userId": userId,
        "causeNum": causeNum,
        "cause": cause,
        "clientName": clientName,
        "causeType": causeType,
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

  createDiaryDetailsApi(
    diaryId,
    startDate,
    appointment,
    actions,
    toDo,
    notes,
  ) async {
    try {
      var url = "$domain/api/v1/details";
      var body = jsonEncode({
        "diaryId": diaryId,
        "startDate": startDate,
        "appointment": appointment,
        "actions": actions,
        "toDo": toDo,
        "notes": notes,
      });
      print(">>>>>>>>>>> create diary details url $url");
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
      var url = "$domain/api/v1/diaries/$id";
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
        Uri.parse("$domain/api/v1/notes/categoryId/$categoryId"),
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

  createNoteApi(userId ,categoryId, title, notes, attachment) async {
    try {
      var url = "$domain/api/v1/notes";
      var body = jsonEncode({
        "userId": userId,
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
    userId,
    noteId,
    title,
    notes,
  ) async {
    try {
      var url = "$domain/api/v1/notes/$userId/$noteId";
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

  getAllNotesCategoryApi(String userId) async {
    try {
      var response = await http.get(
        Uri.parse("$domain/api/v1/note-categories/userid/$userId"),
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

  createNoteCategoryApi(userId,categoryName) async {
    try {
      var url = "$domain/api/v1/note-categories";
      var body = jsonEncode({
        "userId": userId,
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
    userId,
    id,
    categoryName,
  ) async {
    try {
      var url = "$domain/api/v1/note-categories/$userId/$id";
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
    id,
    diaryId,
    startDate,
    appointment,
    actions,
    toDo,
    notes,
  ) async {
    try {
      print('diary id >>>>>>>>>>>${id}');
      var url = "$domain/api/v1/details/$id";
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
}
