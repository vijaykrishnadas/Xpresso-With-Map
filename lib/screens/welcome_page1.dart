import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomePage1 extends StatefulWidget {
  const WelcomePage1({Key? key}) : super(key: key);

  @override
  State<WelcomePage1> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage1> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    int _number;
    String _password;
    bool onTap = false;
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Color.fromRGBO(25, 9, 51, 1),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                      child: Lottie.network(
                          'https://assets2.lottiefiles.com/packages/lf20_puciaact.json')),
                ),
                TabBar(
                  tabs: [
                    Tab(
                      icon: Icon(
                        Icons.account_circle_outlined,
                        color: Colors.white,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.account_circle_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(children: [
                    Login(formKey: _formKey),
                    Login(formKey: _formKey),
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Login extends StatelessWidget {
  const Login({
    Key? key,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;




  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Card(
          shadowColor: Colors.blueAccent,
          elevation: 6.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Registration",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    focusNode: FocusNode(),
                    maxLength: 10,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple),
                      ),
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Theme.of(context).primaryColorDark,
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
                  TextFormField(
                    focusNode: FocusNode(),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple),
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: Color(0xFF6200EE),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurpleAccent,
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        )),
                    onPressed: () {
                      debugPrint("OTP Btn Clicked");
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("Send OTP"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
