import 'dart:convert'; // Add this for JSON decoding
import 'package:dartz/dartz.dart';
import 'package:flutter_pos_app/core/constants/variables.dart';
import 'package:flutter_pos_app/data/models/response/auth_response_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
    String email,
    String password,
  ) async {
   final response = await http.post(
   Uri.parse('${Variables.baseUrl}/api/login'),
   body: {
     'email': email,
     'password': password,
   },
);

print(response.body); // Log the response body

if (response.statusCode == 200) {
   try {
      return right(AuthResponseModel.fromJson(response.body));
   } catch (e) {
      print('Error parsing response: $e');
      return left('Error parsing response');
   }
} else {
   return left('Error: ${response.body}');
}

  }
}
