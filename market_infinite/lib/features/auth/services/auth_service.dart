import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:market_infinite/constants/global_variables.dart';
import 'package:market_infinite/constants/utils.dart';
import 'package:market_infinite/features/home/screens/home_screen.dart';
import 'package:market_infinite/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  // sign in user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,}) async
  {
    try
    {
      http.Response res=await http.post(
        Uri.parse('$uri/api/signin') ,
        body: jsonEncode({
          "email": email,
          "password": password
        }),
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(response: res, context: context, onSuccess: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        Provider.of<UserProvider>(context,listen: false).setUser(res.body);
        await prefs.setString("x-auth-token", jsonDecode(res.body)["token"]);
        Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false,);
      },
      );
    }
    catch(e)
    {
      showSnackBar(context, e.toString());
    }
  }

}