import 'package:flutter/material.dart';

class SellerScreen extends StatefulWidget {
  const SellerScreen({super.key});

  @override
  State<SellerScreen> createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Seller Page')));
  }
}
