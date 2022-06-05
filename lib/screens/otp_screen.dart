import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import '../service/auth_service.dart';

class OTPScreen extends StatefulWidget {
  final String vID;
  OTPScreen(this.vID);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpController = TextEditingController();
  AuthService authService = AuthService(FirebaseAuth.instance);
  String verificationID = "hello";
  String smsCode = "";
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
                      child: Lottie.network(
                          'https://assets2.lottiefiles.com/packages/lf20_o7vsrokz.json')),
                ),
              ),
              Container(
                child: Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "Verification",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          "Enter the OTP code that you have received on your number.",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20,),
                        Card(
                          shadowColor: Colors.blueAccent,
                          elevation: 6.0,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Form(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  TextFormField(
                                    controller: otpController,
                                    focusNode: FocusNode(),
                                    maxLength: 6,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.deepPurple),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color:
                                        Theme.of(context).primaryColorDark,
                                      ),
                                      labelText: 'Enter OTP',
                                      labelStyle: TextStyle(
                                        color: Color(0xFF6200EE),
                                      ),
                                    ),
                                  ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     OTPTextBox(),
                                  //     OTPTextBox(),
                                  //     OTPTextBox(),
                                  //     OTPTextBox(),
                                  //     OTPTextBox(),
                                  //     OTPTextBox(),
                                  //   ],
                                  // ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                    onPressed: () async{
                                      setState(() {
                                        // setloading
                                      });
                                      await authService.verifyOTP(otpController.text, context, widget.vID);
                                    },
                                    child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        child: Center(child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Text("Verify OTP",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ))),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Did'nt receive any code?",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: (){
                            debugPrint("Resend OTP");
                          },
                          child: Text(
                            "Resend OTP",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.purple,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OTPTextBox extends StatelessWidget {
  const OTPTextBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: 44,
      child: TextFormField(
        onChanged: (value){
          if(value.length == 1){
            FocusScope.of(context).nextFocus();
          }
        },
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],

      ),
    );
  }
}
