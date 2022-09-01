import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_vendor/views/auth/customer_login_screen.dart';
import 'package:multi_vendor/views/auth/landing_customer_screen.dart';
import 'package:multi_vendor/views/auth/landing_seller_screen.dart';
import 'package:multi_vendor/views/auth/seller_login_screen.dart';
import 'package:multi_vendor/views/customer_home_screen.dart';
import 'package:multi_vendor/views/seller_home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => print('Completed'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        fontFamily: "Brand-Bold",
      ),
      initialRoute: SellerHomeScreen.routeName,
      routes: {
        CustomerHomeScreen.routeName: (context) => const CustomerHomeScreen(),
        LandingCustomerScreen.routeName: (context) =>
            const LandingCustomerScreen(),
        LandingSellerScreen.routeName: (context) => const LandingSellerScreen(),
        SellerLoginScreen.routeName: (context) => const SellerLoginScreen(),
        SellerHomeScreen.routeName: (context) => const SellerHomeScreen(),
      },
    );
  }
}
