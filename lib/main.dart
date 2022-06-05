import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mca_project/providers/user_provider.dart';
import 'package:mca_project/screens/welcome_page.dart';
import 'package:mca_project/service/auth_service.dart';
import 'package:mca_project/service/maps_service.dart';
import 'package:provider/provider.dart';


Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

final List color = ['125B50', 'F8B400', 'FAF5E4', 'FF6363'];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
        create: (_) => AuthService(FirebaseAuth.instance)
        ),
        StreamProvider(
            create: (context) => context.read<AuthService>().authState,
            initialData: null,
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GenerateMaps(),
        )
      ],
    child: MaterialApp(
      title: 'Flutter Demo',
                      theme: ThemeData(
                          inputDecorationTheme: const InputDecorationTheme(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red))),
                          primarySwatch: Colors.deepPurple,
                          textTheme: GoogleFonts.poppinsTextTheme()),
      home: const AuthWrapper(),
    ),
      );
  }
}

class AuthWrapper extends StatelessWidget{
  const AuthWrapper({Key? key}) : super(key :key);
  @override

  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if(firebaseUser != null)
      {
        var result = AuthService(FirebaseAuth.instance).getDocID(firebaseUser.phoneNumber, context);
        print("HI");
        // Provider.of<UserProvider>(context).getUser(firebaseUser.phoneNumber, context);
      }
    else
      {
        return WelcomePage();
      }
    return Container();
  }
}
