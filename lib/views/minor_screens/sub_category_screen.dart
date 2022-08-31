import 'package:flutter/material.dart';

class SubCategoryScreen extends StatelessWidget {
  final String subCategoryName;
  final String mainCategory;
  const SubCategoryScreen(
      {Key? key, required this.subCategoryName, required this.mainCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          subCategoryName,
          style: const TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Center(
        child: Text(
          mainCategory,
        ),
      ),
    );
  }
}
