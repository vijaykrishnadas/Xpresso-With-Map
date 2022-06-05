import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../screens/driver_register_done_page.dart';
import '../screens/driver_register_homepage.dart';
import '../screens/home_screen.dart';
import '../screens/otp_screen.dart';

class AuthService {
  final FirebaseAuth _auth;
  AuthService(this._auth);

  //State Persistance

  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();
  // FirebaseAuth.instance.userChanges()
  // FirebaseAuth.instance.idTokenChanges()

  Future<void> phoneSignIn(
      BuildContext context,
      String phoneNumber,
      )
  async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async{
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          showSnackBar(context, e.message!);
        },
        codeSent: ((String verificationId, int? resendToken) async{
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  OTPScreen(verificationId)),
          );
          showSnackBar(context, "OTP code sent to User");
        }),
        codeAutoRetrievalTimeout: (String verificationId){});
  }

  //Create User Object based on Firebase User

  void signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential, BuildContext context) async{
    try{
      final authCredential = await _auth.signInWithCredential(phoneAuthCredential);
      if(authCredential.user !=null){
        // UserModel(authCredential.user?.uid);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DriverRegistrationHomepage()),
        );
      }
      showSnackBar(context, "User Logged In");
    }
    on FirebaseAuthException catch(err)
    {
      debugPrint(err.toString());
      showSnackBar(context, "OTP failed");
    }
  }

  Future<void> verifyOTP(String otp, BuildContext context, String vID)
  async{
    try{
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: vID, smsCode:otp);
      signInWithPhoneAuthCredential(phoneAuthCredential, context);

    }
    catch(err){
      debugPrint(err.toString());
    }
  }
  void showSnackBar(BuildContext context, String text)
  {
    final snackBar = SnackBar(content: Text(text.toString()));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future getDocID(phoneController, context) async{
    print(phoneController);
    await FirebaseFirestore.instance.collection('drivers').get().then(
            (snapshot) => snapshot.docs.forEach((element) {
          if(element.id == phoneController) {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) =>  HomeScreen(element.id, element.data())),
            // );
            final Map<String, dynamic> userData = element.data();
            if(userData['Verification Status'] == false)
            {

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  DriverRegistrationDonePage()),
              );
            }
            else

            {
              print(element.data());
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  HomeScreen(element.id, element.data())),
              );
            }
          }
          else{
            print("User not found");
          }
        })
    );
  }
}

