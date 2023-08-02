import 'package:flutter/material.dart';
import 'package:market_infinite/common/widgets/loader.dart';
import 'package:market_infinite/features/admin/services/admin_services.dart';

import '../models/sales.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async{
    var earningData = await adminServices.getEarnings(context: context);
    totalSales = earningData["totalEarnings"];
    earnings = earningData["sales"];
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales ==null ? Loader() :  Column(
      children: [
        Text("\$${totalSales}",
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        ),
      ],
    );
  }
}