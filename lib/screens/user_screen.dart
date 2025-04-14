import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            width: 350,
            height: 200,

            child: Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nike Air One', style: TextStyle(fontSize: 22)),
                      Text('WOW', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, bottom: 60),
                  alignment: Alignment.bottomLeft,
                  width: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -10,
                  right: 0,
                  child: Image.asset('assets/images/shoe.png', height: 170),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
