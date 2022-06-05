import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mca_project/screens/otp_screen.dart';
import 'package:mca_project/service/auth_service.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController phoneController = TextEditingController();
  AuthService authService = AuthService(FirebaseAuth.instance);
  String verificationID = "hello";
  String smsCode = "";
  bool loading = false;
  void phoneSignIn(){
    authService.phoneSignIn(context,  "+91 ${phoneController.text}");
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color.fromRGBO(25, 9, 51, 1),
        body: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Container(
                child: Expanded(
                  child: Container(
                    child: loading!=true? Lottie.network(
                        'https://assets10.lottiefiles.com/packages/lf20_nuxkbxue.json'):
                    Lottie.network(
                        'https://assets7.lottiefiles.com/packages/lf20_yyytgjwe.json'),
                  ),
                ),
              ),
              Container(
                child: Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "Registration / Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Add your phone number. We'll send you a verification code, so we know that you are real.",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Card(
                          shadowColor: Colors.blueAccent,
                          elevation: 6.0,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Form(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: phoneController,
                                    focusNode: FocusNode(),
                                    maxLength: 10,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.deepPurple),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.phone,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                      labelText: 'Phone Number',
                                      labelStyle: TextStyle(
                                        color: Color(0xFF6200EE),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        loading = true;

                                      });
                                      phoneSignIn();
                                    },
                                    child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Center(
                                            child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Text(
                                            "Send OTP",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ))),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setData(verificationID) {
    setState(() {
      verificationID = verificationID;
    });
  }
}
