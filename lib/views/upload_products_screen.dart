import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_vendor/controllers/snack_bar_controller.dart';

class UploadProductsScreen extends StatefulWidget {
  const UploadProductsScreen({Key? key}) : super(key: key);

  @override
  State<UploadProductsScreen> createState() => _UploadProductsScreenState();
}

class _UploadProductsScreenState extends State<UploadProductsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late double price;
  late int quantity;
  late String productName;
  late String productDescription;

  final ImagePicker _picker = ImagePicker();

  List<XFile>? imageList = [];

  String mainCategory = 'men';

  void pickProductImages() async {
    try {
      final pickedImages = await _picker.pickMultiImage(
        maxHeight: 300,
        maxWidth: 300,
        imageQuality: 100,
      );
      setState(() {
        imageList = pickedImages!;
      });
    } catch (e) {}
  }

  Widget displayImages() {
    if (imageList!.isNotEmpty) {
      return InkWell(
        onTap: () {
          setState(() {
            imageList = null;
          });
        },
        child: ListView.builder(
          itemCount: imageList!.length,
          itemBuilder: (context, index) {
            return Image.file(File(imageList![index].path));
          },
        ),
      );
    } else {
      return const Center(
        child: Text(
          'You Have not\n \nPicked any Images',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.5,
                      color: Colors.blueGrey.shade100,
                      child: Center(
                        child: imageList != null
                            ? displayImages()
                            : const Text(
                                'You Have not\n \nPicked any Images',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                      ),
                    ),
                    Column(
                      children: [
                        const Text('Select Main Category'),
                        DropdownButton(
                          value: mainCategory,
                          items: const [
                            DropdownMenuItem(
                              value: 'men',
                              child: Text('men'),
                            ),
                            DropdownMenuItem(
                              value: 'women',
                              child: Text('women'),
                            ),
                            DropdownMenuItem(
                              value: 'shoes',
                              child: Text('shoes'),
                            ),
                          ],
                          onChanged: ((String? value) {
                            setState(() {
                              mainCategory = value!;
                            });
                          }),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                  child: Divider(
                    color: Colors.cyan,
                    thickness: 1.4,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.38,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Price must not be empty';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Price',
                        hintText: 'Add Price',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      onSaved: (value) {
                        price = double.parse(value!);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Quantity must not be empty';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Quantity',
                        hintText: 'Add Quantity',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      onSaved: (value) {
                        quantity = int.parse(value!);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Product Name must not be empty';
                        } else {
                          return null;
                        }
                      },
                      maxLength: 100,
                      maxLines: 2,
                      decoration: InputDecoration(
                        labelText: 'Product Name',
                        hintText: 'Enter Product Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      onSaved: (value) {
                        productName = value!;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Product Description must not be empty';
                        } else {
                          return null;
                        }
                      },
                      maxLength: 800,
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: 'Product Description',
                        hintText: 'Enter Product Description',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      onSaved: (value) {
                        productDescription = value!;
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: FloatingActionButton(
              onPressed: (() {
                pickProductImages();
              }),
              child: const Icon(
                Icons.photo_library,
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                if (imageList!.isNotEmpty) {
                  print(price);
                  print(quantity);
                  print(productName);
                  print(productDescription);
                  setState(() {
                    imageList = [];
                  });
                  _formKey.currentState!.reset();
                } else {
                  snackBar('Please Pick Images', context);
                }
              } else {
                snackBar('Please Fields Must not be left emtpy', context);
              }
            },
            child: const Icon(
              Icons.upload,
            ),
          )
        ],
      ),
    );
  }
}
