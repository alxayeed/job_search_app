import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String appBarTitle;
  CustomAppBar({super.key, required this.appBarTitle});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 100.0,
      pinned: true,
      floating: false,
      centerTitle: true,
      backgroundColor: Colors.blueAccent,
      title: Text(
        this.appBarTitle,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.lightBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      leading: Builder(builder: (context) {
        return IconButton(
          onPressed: () => Scaffold.of(context).openDrawer(),
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
        );
      }),
      // actions: [
      //   IconButton(
      //     icon: Icon(Ionicons.heart, color: Colors.white),
      //     onPressed: () {
      //       // Action for notifications icon
      //     },
      //   ),
      // ],
    );
  }
}
