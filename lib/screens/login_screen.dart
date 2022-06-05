import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mca_project/providers/user_provider.dart';
import 'package:mca_project/screens/driver_register_done_page.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  // Future getDocID() async{
  //   print(phoneController.text);
  //   await FirebaseFirestore.instance.collection('drivers').get().then(
  //           (snapshot) => snapshot.docs.forEach((element) {
  //         if(element.id == '+91${phoneController.text}') {
  //           // Navigator.push(
  //           //   context,
  //           //   MaterialPageRoute(builder: (context) =>  HomeScreen(element.id, element.data())),
  //           // );
  //           final Map<String, dynamic> userData = element.data();
  //           if(userData['Verification Status'] == false)
  //             {
  //
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(builder: (context) =>  DriverRegistrationDonePage()),
  //               );
  //             }
  //           else
  //
  //             {
  //               print(element.data());
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(builder: (context) =>  HomeScreen(element.id, element.data())),
  //               );
  //             }
  //         }
  //         else{
  //           print("User not found");
  //         }
  //       })
  //   );
  // }

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
                  child: Column(
                    children: [
                      Container(
                        child: Expanded(
                          child: Container(
                              child: Lottie.network(
                                  'https://assets2.lottiefiles.com/packages/lf20_o7vsrokz.json')),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Kindly enter your Phone Number and Password to Login",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        style: TextStyle(
                          color: Colors.white
                        ),
                        controller: phoneController,
                        focusNode: FocusNode(),
                        maxLength: 10,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white),
                          ),
                          prefixIcon: Icon(
                            Icons.phone,
                            color:
                            Theme.of(context).primaryColorDark,
                          ),
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      TextFormField(
                        style: TextStyle(
                            color: Colors.white
                        ),
                        controller: passwordController,
                        focusNode: FocusNode(),

                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white),
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color:
                            Theme.of(context).primaryColorDark,
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          print("LOGIN BTN");
                          Provider.of<UserProvider>(context).getUser(phoneController, context);
                        },
                        child: Container(
                            width:
                            MediaQuery.of(context).size.width,
                            child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
