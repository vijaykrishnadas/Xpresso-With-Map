import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mca_project/screens/register_screen.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        'https://assets2.lottiefiles.com/packages/lf20_puciaact.json')),
              ),
            ),
            Container(
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Let's get started",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "Never a better time than now to start",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Register()),
                        );
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Center(child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text("Create Account / Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ))),
                    ),
                    // SizedBox(height: 20,),
                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //       onPrimary: Theme.of(context).primaryColorDark,
                    //       primary: Colors.white,
                    //   ),
                    //   onPressed: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(builder: (context) => const Login()),
                    //     );
                    //   },
                    //   child: Container(
                    //       width: MediaQuery.of(context).size.width,
                    //       child: Center(child: Padding(
                    //         padding: const EdgeInsets.all(20.0),
                    //         child: Text("Login",
                    //         style: TextStyle(
                    //           fontWeight: FontWeight.bold
                    //         ),
                    //         ),
                    //       ))),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


