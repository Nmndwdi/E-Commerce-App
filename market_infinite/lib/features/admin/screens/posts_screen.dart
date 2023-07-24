import 'package:flutter/material.dart';
import 'package:market_infinite/constants/global_variables.dart';
import 'package:market_infinite/features/admin/screens/add_product_screen.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {

  void navigateToAddProduct()
  {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text("Products"),),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddProduct,
        tooltip: "Add a Product",
        child: const Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 29, 201, 192),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}