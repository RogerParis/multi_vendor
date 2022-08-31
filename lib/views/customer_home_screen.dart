import 'package:flutter/material.dart';
import 'package:multi_vendor/views/cart_screen.dart';
import 'package:multi_vendor/views/category_screen.dart';
import 'package:multi_vendor/views/home_screen.dart';
import 'package:multi_vendor/views/profile_screen.dart';

class CustomerHomeScreen extends StatefulWidget {
  static const String routeName = 'CustomerHomeScreen';

  const CustomerHomeScreen({Key? key}) : super(key: key);

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int _selctedItem = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    CategoryScreen(),
    const Center(
      child: Text('Shop Screen'),
    ),
    const CartScreen(),
    const ProfileScreen()
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
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: _pages[_selctedItem],
    );
  }
}
