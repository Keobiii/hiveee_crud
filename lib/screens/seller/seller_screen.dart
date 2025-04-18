import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hiveee/widget/gradient_button.dart';

class SellerScreen extends StatefulWidget {
  const SellerScreen({super.key});

  @override
  State<SellerScreen> createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              GradientButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/addProduct');
                },
                text: 'Add Product',
              ),
              SizedBox(height: 20),
              GradientButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/listProduct');
                },
                text: 'Product List',
              ),
              SizedBox(height: 20),
              GradientButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/listOrder');
                },
                text: 'Order List',
              ),
              SizedBox(height: 20),
              GradientButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                },
                text: 'Logout',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
