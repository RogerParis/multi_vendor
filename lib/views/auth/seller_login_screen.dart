import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor/controllers/snack_bar_controller.dart';
import 'package:multi_vendor/views/auth/landing_customer_screen.dart';
import 'package:multi_vendor/views/seller_home_screen.dart';

class SellerLoginScreen extends StatefulWidget {
  static const String routeName = 'SellerLoginScreen';

  const SellerLoginScreen({Key? key}) : super(key: key);

  @override
  State<SellerLoginScreen> createState() => _SellerLoginScreenState();
}

class _SellerLoginScreenState extends State<SellerLoginScreen> {
  bool passwordVisible = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String email;
  late String password;
  bool isLoading = false;

  loginSeller() async {
    try {
      if (_formKey.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .whenComplete(
              () => setState(() {
                isLoading = false;
              }),
            );

        Navigator.of(context).pushNamedAndRemoveUntil(
            SellerHomeScreen.routeName, (route) => false);
      } else {
        snackBar('Please Fields must not be empty', context);
      }
    } catch (e) {
      snackBar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Sign In to Sellers Account',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Brand-Regular",
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.person,
                          size: 35,
                          color: Colors.cyan,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          email = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Email Address must not be empty';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              25,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onChanged: (value) {
                          password = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Password must not be empty';
                          } else {
                            return null;
                          }
                        },
                        obscureText: passwordVisible,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                            icon: Icon(
                              passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          labelText: 'Password',
                          hintText: 'Enter your Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              25,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          loginSeller();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width - 40,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.cyan,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Need an Account?',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: ((context) {
                                return const LandingCustomerScreen();
                              })));
                            },
                            child: const Text('Sign Up'),
                          )
                        ],
                      ),
                      const Text(
                        'Or',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Create a seller Account?',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Sign Up'),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
