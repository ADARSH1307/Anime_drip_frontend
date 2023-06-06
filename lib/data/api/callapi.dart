import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopping_app/uitls/app_constants.dart';

class CallApi{
  postReview(data, apiUrl) async {
    var fullurl = AppConstants.BASE_URL + apiUrl;
   return await http.post(
      Uri.parse(fullurl),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
}