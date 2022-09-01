import 'package:flutter/material.dart';
import 'package:multi_vendor/views/cart_screen.dart';
import 'package:multi_vendor/views/category_screen.dart';
import 'package:multi_vendor/views/home_screen.dart';
import 'package:multi_vendor/views/profile_screen.dart';

class SellerHomeScreen extends StatefulWidget {
  static const String routeName = 'SellerHomeScreen';

  const SellerHomeScreen({Key? key}) : super(key: key);

  @override
  State<SellerHomeScreen> createState() => _SellerHomeScreenState();
}

class _SellerHomeScreenState extends State<SellerHomeScreen> {
  int _selctedItem = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    CategoryScreen(),
    const Center(
      child: Text('Shop Screen'),
    ),
    const Center(
      child: Text('Dashboard'),
    ),
    const Center(
      child: Text('Upload'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.cyan,
        currentIndex: _selctedItem,
        onTap: ((index) {
          setState(() {
            _selctedItem = index;
          });
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: 'Upload',
          ),
        ],
      ),
      body: _pages[_selctedItem],
    );
  }
}
