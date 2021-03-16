import 'package:flutter/material.dart';

import '../data/data.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
//82 212 182 107
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      leading: IconButton(
        icon: Icon(Icons.account_circle),
        color: Colors.yellow,
        iconSize: 30.0,
        onPressed: () {},
      ),
      title: Text('STX Food Delivery',
      style: TextStyle(color: Color(0xffffeb3b)),
       ),
        actions: <Widget>[
          TextButton(child: Text('Cart (${currentUser.cart.length})',
            style: TextStyle(color: Colors.yellow,
                fontSize: 20.0),),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20.0),
          child: TextField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 15.0),
            fillColor: Colors.blueGrey,
            filled: true,
            border: OutlineInputBorder(borderRadius:
            BorderRadius.circular(30.0),
            borderSide: BorderSide(width: 0.8),
            ),
              hintText: 'Search Food or Restaurants',
              hintStyle: TextStyle(color: Colors.white),
              prefixIcon: Icon(Icons.search, size: 30.0,
              ),
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {},
              )
            ),
          ),
        ),
      ],
      ),
    );
  }
}
