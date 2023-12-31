import 'package:flutter/material.dart';
import 'package:market_infinite/common/widgets/loader.dart';
import 'package:market_infinite/features/account/widgets/single_product.dart';
import 'package:market_infinite/features/admin/screens/add_product_screen.dart';
import 'package:market_infinite/features/admin/services/admin_services.dart';

import '../../../models/product.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Product>? products;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async{
    products = await adminServices.fetchAllProducts(context: context,);
    setState(() {
      
    });
  }

  void deleteProduct(Product product,int index)
  {
    adminServices.deleteProduct(context: context, product: product, onSuccess: () {
      products!.removeAt(index);
      setState(() {
        
      });
    },);
  }

  void navigateToAddProduct()
  {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return products == null ? const Loader() : Scaffold(
      body: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: products!.length,
        itemBuilder: (context,index) {
        final productData = products![index];
         return Column(
          children: [
            SizedBox(
              height: 130,
              child: SingleProduct(image: productData.images[0]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        productData.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ),
                ),
                IconButton(onPressed: () => deleteProduct(productData,index), icon: const Icon(Icons.delete_outline,),),
              ],
            ),
          ],
         );
      },),

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