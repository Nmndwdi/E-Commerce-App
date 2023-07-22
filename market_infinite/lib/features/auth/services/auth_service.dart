import 'package:flutter/material.dart';
import 'package:market_infinite/constants/global_variables.dart';
import 'package:market_infinite/constants/utils.dart';

import '../../../constants/error_handling.dart';
import '../../../models/user.dart';
import 'package:http/http.dart' as http;

class AuthService{

  // sign up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    }) async
  {
    try
    {
      User user = User(id: '', name: name, password: password,email: email ,address: '', type: 'user', token: '');
      
      http.Response res=await http.post(
        Uri.parse('$uri/api/signup') ,
        body:  user.toJson(),
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(response: res, context: context, onSuccess: (){
        showSnackBar(context, 'Account created! Login with the same credentials!',
        );
      },
      );
    }
    catch(e)
    {
      showSnackBar(context, e.toString());
    }
  }
}