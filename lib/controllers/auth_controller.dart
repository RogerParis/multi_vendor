import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  pickImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      print('Reading bytes from image');
      return file.readAsBytes();
    } else {
      print('No Image selected');
    }
  }

  Future<String> _uploadImageToStorage(Uint8List image) async {
    Reference ref =
        _firebaseStorage.ref().child('profiles').child(_auth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<String> signUpUsers(
      String fullName, String email, String password, Uint8List? image) async {
    String result = 'some error occured';
    try {
      if (fullName.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String downloadUrl = await _uploadImageToStorage(image);
        await _firestore.collection('customers').doc(credential.user!.uid).set({
          'cid': credential.user!.uid,
          'full_name': fullName,
          'email': email,
          'image': downloadUrl,
          'address': '',
        });
        result = 'success';
        print('Account Created');
      } else {
        result = 'Fields must not be empty';
        print('Fields must not be empty');
      }
    } catch (e) {
      result = e.toString();
      print('Error signing up user: ');
      print(result);
    }
    return result;
  }

  Future<String> loginUsers(String email, String password) async {
    String result = 'some error occured';

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        result = 'success';
        print('Login successfully');
      } else {
        result = 'Fields must not be empty';
        print('Fields must not be empty');
      }
    } catch (e) {
      result = e.toString();
      print('Error signing in user: ');
      print(result);
    }
    return result;
  }
}
