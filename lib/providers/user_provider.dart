import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  Future getUser(phoneController, context) async {
    print(phoneController);
    await FirebaseFirestore.instance.collection('drivers').get().then(
            (snapshot) =>
            snapshot.docs.forEach((element) {
              if (element.id == phoneController) {
                final Map<String, dynamic> userData = element.data();
                print("HIHIHIHIHI" +userData.toString());
                notifyListeners();
              }
              else {
                print("User not found");
              }
            })
    );
  }
}
