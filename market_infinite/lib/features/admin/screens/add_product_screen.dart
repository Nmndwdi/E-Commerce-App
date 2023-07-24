import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:market_infinite/common/widgets/custom_button.dart';
import 'package:market_infinite/common/widgets/custom_textfield.dart';
import 'package:market_infinite/constants/utils.dart';

import '../../../constants/global_variables.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = "/add-product";
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {

  TextEditingController productNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  String category = "Mobiles";
  List<File> images = [];

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  List<String> productCategories = [
    "Mobiles",
    "Essentials",
    "Appliances",
    "Books",
    "Fashion",
  ];

  void selectImages() async{
    var res=await pickImages();
    setState(() {
      images=res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: const Text("Add Product",style: TextStyle(color: Colors.black),),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(height: 20,),
                GestureDetector(
                  onTap: selectImages,
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(10),
                    dashPattern: const [10,4],
                    strokeCap: StrokeCap.round,
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.folder_open,size: 40,),
                          const SizedBox(height: 15,),
                          Text(
                            "Select Product Images",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade400,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                CustomtextField(controller: productNameController, hintText: "Product Name"),
                const SizedBox(height: 10,),
                CustomtextField(controller: descriptionController, hintText: "Description",maxLines: 7,),
                const SizedBox(height: 10,),
                CustomtextField(controller: priceController, hintText: "Price"),
                const SizedBox(height: 10,),
                CustomtextField(controller: quantityController, hintText: "Quantity"),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: category,
                    icon: const Icon(Icons.keyboard_arrow_down,),
                    items: productCategories.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                        );
                    }).toList(),
                    onChanged: (String? newVal){
                      setState(() {
                        category=newVal!;
                      });
                    }
                  ),
                ),
                const SizedBox(height: 10,),
                CustomButton(text: "Sell", onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}