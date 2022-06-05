import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DriverRegistrationDonePage extends StatelessWidget {
  const DriverRegistrationDonePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromRGBO(25, 9, 51, 1),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Xpresso",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 32
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text("Thank You for Registering. \n Kindly give us some time to verify your details. \n\n We will get back to you shortly..",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  SystemNavigator.pop();
                  FirebaseAuth.instance.signOut();
                },
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Center(child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text("Exit",
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
    );
  }
}
