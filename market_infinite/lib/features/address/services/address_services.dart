import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:market_infinite/constants/error_handling.dart';
import 'package:market_infinite/constants/global_variables.dart';
import 'package:market_infinite/constants/utils.dart';
import 'package:market_infinite/models/product.dart';

import 'package:http/http.dart' as http;
import 'package:market_infinite/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/user.dart';

class AddressServices
{
  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async
  {
    final userProvider = Provider.of<UserProvider>(context,listen: false);
    try
    {
      http.Response res = await http.post(Uri.parse("$uri/api/save-user-address"),
      headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          "address": address,
        }),
      );

      httpErrorHandle(response: res, context: context, onSuccess: () {
        User user = userProvider.user.copyWith(
          address: jsonDecode(res.body)["address"]
        );
        userProvider.setUserFromModel(user);
      },);
    }
    catch(e)
    {
      showSnackBar(context, e.toString());
    }
  }

  // get all the products
  void placeOrder({required BuildContext context,required String address,required double totalSum}) async
  {
    final userProvider = Provider.of<UserProvider>(context,listen: false);
    try
    {
      http.Response res = await http.post(Uri.parse("$uri/api/order"),
      headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          "cart": userProvider.user.cart,
          "address": address,
          "totalPrice": totalSum,
        }));
      httpErrorHandle(response: res, context: context, onSuccess: (){
        showSnackBar(context, "Your order has been successfully placed!");
        User user = userProvider.user.copyWith(
          cart: [],
        );
        userProvider.setUserFromModel(user);
      },);
    }
    catch(e)
    {
      showSnackBar(context, e.toString());
    }
  }

  // Delete the product

  void deleteProduct({required BuildContext context,required Product product, required VoidCallback onSuccess,}) async
  {
    final userProvider = Provider.of<UserProvider>(context,listen: false);
    try
    {
      http.Response res = await http.post(Uri.parse("$uri/admin/delete-product"),
      headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );

      httpErrorHandle(response: res, context: context, onSuccess: () {
        onSuccess();
      },);
    }
    catch(e)
    {
      showSnackBar(context, e.toString());
    }
  }

}