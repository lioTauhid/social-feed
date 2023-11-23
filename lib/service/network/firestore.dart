import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../model/Post.dart';

class FirebaseService {
  static final User? user = FirebaseAuth.instance.currentUser;
  static final db = FirebaseFirestore.instance;
  static final storage = FirebaseStorage.instance;

  String? saveDataCollection(String path, dynamic data) {
    db.collection(path).add(data.toJson()).then((DocumentReference doc) {
      print('DocumentSnapshot added with ID: ${doc.id}');
      return doc.id;
    });
    return null;
  }

  Future<dynamic> getDataCollection(String path) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection('posts').get();
    return snapshot.docs;
  }

  Future<String?> uploadFileToFirebase(String localFilePath) async {
    print(localFilePath);
    File file = File(localFilePath);
    if (!await file.exists()) {
      print('File does not exist.');
      return null;
    }

    String fileName =
        'images/${user!.email!.split('@')[0]}_${file.path.split('/').last}';
    final storageRef = storage.ref().child(fileName);

    try {
      await storageRef.putFile(file);
      print('File uploaded successfully.');

      final downloadURL = await storageRef.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error uploading file: $e');
      return null;
    }
  }
}
