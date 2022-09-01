import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_vendor/controllers/auth_controller.dart';
import 'package:multi_vendor/controllers/snack_bar_controller.dart';
import 'package:multi_vendor/views/auth/landing_customer_screen.dart';
import 'package:multi_vendor/views/auth/seller_login_screen.dart';

class LandingSellerScreen extends StatefulWidget {
  static const String routeName = 'LandingSellerScreen';
  const LandingSellerScreen({Key? key}) : super(key: key);

  @override
  State<LandingSellerScreen> createState() => _LandingSellerScreenState();
}

class _LandingSellerScreenState extends State<LandingSellerScreen> {
  bool passwordVisible = true;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final AuthController _authController = AuthController();

  late String fullName;
  late String email;
  late String password;

  bool isLoading = false;
  Uint8List? _image;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  pickImageFromGallery() async {
    Uint8List img = await _authController.pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  pickImageFromCamera() async {
    Uint8List img = await _authController.pickImage(ImageSource.camera);
    setState(() {
      _image = img;
    });
  }

  void signUp() async {
    try {
      if (_formkey.currentState!.validate()) {
        if (_image != null) {
          setState(() {
            isLoading = true;
          });
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password);
          String downloadUrl = await _uploadImageToStorage(_image!);
          await _firebaseFirestore
              .collection('sellers')
              .doc(_firebaseAuth.currentUser!.uid)
              .set({
            'seller_uid': _firebaseAuth.currentUser!.uid,
            'store_name': fullName,
            'email': email,
            'address': '',
            'image': downloadUrl,
          }).whenComplete(() => {
                    setState(() {
                      isLoading = false;
                    })
                  });

          _formkey.currentState!.reset();
          setState(() {
            _image = null;
          });
        } else {
          snackBar('Please Pick Image', context);
        }
      } else {
        snackBar('Please Fields must not be empty', context);
      }
    } catch (e) {
      snackBar(e.toString(), context);
    }
  }

  Future<String> _uploadImageToStorage(Uint8List image) async {
    Reference ref = _firebaseStorage.ref().child('profiles').child(fullName);
    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Create A Sellers Account',
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
                  Row(
                    children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.cyan,
                              backgroundImage: MemoryImage(_image!),
                            )
                          : const CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.cyan,
                            ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.cyan,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            child: IconButton(
                              onPressed: (() {
                                pickImageFromCamera();
                              }),
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.cyan,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            child: IconButton(
                              onPressed: (() {
                                pickImageFromGallery();
                              }),
                              icon: const Icon(
                                Icons.photo,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Full Name must not be empty';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          hintText: 'Enter your full name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              25,
                            ),
                          ),
                        ),
                        onChanged: (String value) {
                          fullName = value;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Email must not be empty';
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
                        onChanged: (String value) {
                          email = value;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
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
                        onChanged: (String value) {
                          password = value;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          signUp();
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
                                    'Sign Up',
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
                            'Already Have an Account?',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                SellerLoginScreen.routeName,
                              );
                            },
                            child: const Text('Login'),
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
                            'Create Customer Account?',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return const LandingCustomerScreen();
                                },
                              ));
                            },
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
