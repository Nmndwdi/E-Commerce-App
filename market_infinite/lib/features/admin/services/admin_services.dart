import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:market_infinite/constants/error_handling.dart';
import 'package:market_infinite/constants/global_variables.dart';
import 'package:market_infinite/constants/utils.dart';
import 'package:market_infinite/models/product.dart';

import 'package:http/http.dart' as http;
import 'package:market_infinite/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AdminServices
{
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async
  {
    final userProvider = Provider.of<UserProvider>(context,listen: false);
    try
    {
      final cloudinary=CloudinaryPublic("drl7qo2na", "uvbbdhw4");
      List<String>imageUrls = [];
      for(int i=0;i<images.length;i++)
      {
        CloudinaryResponse res = await cloudinary.uploadFile(CloudinaryFile.fromFile(images[i].path,folder: name),);
        imageUrls.add(res.secureUrl);
      }
      Product product = Product(name: name, description: description, price: price, quantity: quantity, category: category, images: imageUrls);

      http.Response res = await http.post(Uri.parse("$uri/admin/add-product"),
      headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: product.toJson(),
      );

      httpErrorHandle(response: res, context: context, onSuccess: () {
        showSnackBar(context, 'Product Added Successfully');
        Navigator.pop(context);
      },);
    }
    catch(e)
    {
      showSnackBar(context, e.toString());
    }
  }

  // get all the products
  Future<List<Product>> fetchAllProducts({required context,}) async
  {
    final userProvider = Provider.of<UserProvider>(context,listen: false);
    List<Product> productList = [];
    try
    {
      http.Response res = await http.get(Uri.parse("$uri/admin/get-products"),
      headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },);
      httpErrorHandle(response: res, context: context, onSuccess: (){
        for(int i=0;i<jsonDecode(res.body).length;i++)
        {
          productList.add(
            Product.fromJson(jsonEncode(jsonDecode(res.body)[i],),),
          );
        }
      },);
    }
    catch(e)
    {
      showSnackBar(context, e.toString());
    }
    return productList;
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