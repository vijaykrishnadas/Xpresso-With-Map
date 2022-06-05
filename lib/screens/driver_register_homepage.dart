import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mca_project/models/user.dart';
import 'package:mca_project/screens/vehicle_register_page.dart';

class DriverRegistrationHomepage extends StatefulWidget {
  const DriverRegistrationHomepage({Key? key}) : super(key: key);

  @override
  State<DriverRegistrationHomepage> createState() =>
      _DriverRegistrationHomepageState();
}

class _DriverRegistrationHomepageState
    extends State<DriverRegistrationHomepage>
    with TickerProviderStateMixin
{
  UserModel? userModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp();
    sucessfullAnimationController = AnimationController(
      // duration: Duration(seconds: 3),
      vsync: this,
    );
    sucessfullAnimationController.addStatusListener((status) async{
      if(status == AnimationStatus.completed)
      {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VehicleRegisterPage(userModel)),
        );
        sucessfullAnimationController.reset();
      }
    });
    unsucessfullAnimationController = AnimationController(
      // duration: Duration(seconds: 3),
      vsync: this,
    );
    unsucessfullAnimationController.addStatusListener((status) async{
      if(status == AnimationStatus.completed)
      {
        Navigator.pop(context);
        unsucessfullAnimationController.reset();
      }
    });
  }
  @override
  void dispose(){
    sucessfullAnimationController.dispose();
    unsucessfullAnimationController.dispose();
    super.dispose();
  }

  PlatformFile? driverProfileFile;
  PlatformFile? aadhaarFile;
  PlatformFile? licenseFile;
  UploadTask? task;
  int? uploadDoc;
  bool isComplete = false;

  late AnimationController sucessfullAnimationController;
  late AnimationController unsucessfullAnimationController;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final dLController = TextEditingController();
  final aCController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser!;
    final userId = user.phoneNumber;

    // Future createUser(UserModel newUser) async {
    //   //reference the document
    //   final docUser =
    //       FirebaseFirestore.instance.collection('drivers').doc(userId);
    //   final json = newUser.toJson();
    //   await docUser.set(json);
    //   //create document and write data to Firestore
    // }

    Future selectFile() async {
      if(uploadDoc == 0)
        {
          final result = await FilePicker.platform.pickFiles(allowMultiple: false);
          if (result == null) {
            return;
          } else {
            final path = result.files.single.path!;
            setState(() =>
            {
              driverProfileFile = result.files.first
            });
          }
        }
      if(uploadDoc == 1)
      {
        final result = await FilePicker.platform.pickFiles(allowMultiple: false);
        if (result == null) {
          return;
        } else {
          final path = result.files.single.path!;
          setState(() =>
          {
            aadhaarFile = result.files.first
          });
        }
      }
      if(uploadDoc == 2)
      {
        final result = await FilePicker.platform.pickFiles(allowMultiple: false);
        if (result == null) {
          return;
        } else {
          final path = result.files.single.path!;
          setState(() =>
          {
            licenseFile = result.files.first
          });
        }
      }
    }

    Future uploadFile() async{
      var d = driverProfileFile;
      var a = aadhaarFile;
      var l = licenseFile;
      if(d!=null && a!=null && l!=null)
        {
          isComplete = true;
          try{
            if(d == null && uploadDoc == 0)
            {
              return;
            }
            else
            {
              final file = File(d.path!);
              final path = '$userId/Driver Profile';
              final ref = FirebaseStorage.instance.ref().child(path);
              task = ref.putFile(file);
              setState(() {
                showDoneDialog("Sucessfully Registered", isComplete);
              });

            }
            if(a == null && uploadDoc == 1)
            {
              return;
            }
            else
            {
              final file = File(a.path!);
              final path = '$userId/Driver Aadhaar';
              final ref = FirebaseStorage.instance.ref().child(path);
              task = ref.putFile(file);
              setState(() {

              });

            }
            if(l == null && uploadDoc == 2)
            {
              return;
            }
            else
            {
              final file = File(l.path!);
              final path = '$userId/Driver license';
              final ref = FirebaseStorage.instance.ref().child(path);
              task = ref.putFile(file);
              setState(() {

              });

            }
          }
          catch(e)
          {
            print(e);
          }
          userModel = UserModel(
              userId.toString(),
              firstNameController.text,
              lastNameController.text,
              dLController.text,
              aCController.text);
          // createUser(newUser);
        }
      else{
        showDoneDialog("Incomplete Data", isComplete);
      }
    }

    Widget buildUploadStatus(UploadTask task)=>StreamBuilder<TaskSnapshot>(
      stream: task.snapshotEvents,
      builder: (context, snapshot){
        if(snapshot.hasData){
          final snap = snapshot.data!;
          final progress = snap.bytesTransferred / snap.totalBytes;
          final percentage = progress * 100;
          return Text(
            '$percentage',
            style: TextStyle(
              color: Colors.white
            ),
          );
        }
        else{
          return Container();
        }
      },
    );
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Color.fromRGBO(25, 9, 51, 1),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
             Text(
                "Register Yourself",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Colors.white),
              ),
              task!=null? buildUploadStatus(task!) : Container(),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Container(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FittedBox(
                                child: ElevatedButton(
                                  onPressed: () {
                                    uploadDoc = 0;
                                    selectFile();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.camera_front),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Upload Driver Image",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: firstNameController,
                                focusNode: FocusNode(),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.deepPurple),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.drive_file_rename_outline,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  labelText: 'First Name',
                                  labelStyle: TextStyle(
                                    color: Color(0xFF6200EE),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: lastNameController,
                                focusNode: FocusNode(),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.deepPurple),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.drive_file_rename_outline,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  labelText: 'Last Name',
                                  labelStyle: TextStyle(
                                    color: Color(0xFF6200EE),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: dLController,
                                focusNode: FocusNode(),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.deepPurple),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.drive_file_rename_outline,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  labelText: "Driver's License Number",
                                  labelStyle: TextStyle(
                                    color: Color(0xFF6200EE),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                validator: (value) {
                                  if(value!.isEmpty)
                                    {
                                      return "Enter Text";
                                    }
                                  else
                                    {
                                      return null;
                                    }
                                },
                                controller: aCController,
                                focusNode: FocusNode(),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.deepPurple),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.drive_file_rename_outline,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  labelText: 'Aadhaar Card Number',
                                  labelStyle: TextStyle(
                                    color: Color(0xFF6200EE),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              FittedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.archive_outlined,
                                    color: Colors.deepPurple,),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Upload Documents",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          color: Colors.deepPurple),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                    ),
                                    onPressed: () async {
                                      uploadDoc = 1;
                                      selectFile();
                                    },
                                    child: Container(
                                        height: 75,
                                        child: Center(
                                            child: Text(
                                          "Aadhaar",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ))),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                    ),
                                    onPressed: () {
                                      uploadDoc = 2;
                                      selectFile();
                                    },
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Container(
                                          height: 75,
                                          child: Center(
                                              child: Text(
                                            "Driver's License",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ))),
                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              driverProfileFile != null?Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text("Profile : " +driverProfileFile!.name,style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12
                                ),),
                              ):Container(),
                              aadhaarFile!= null?Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text("Aadhaar : " +aadhaarFile!.name,style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12
                                ),),
                              ):Container(),
                              licenseFile!= null?Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text("License : " +licenseFile!.name,style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12
                                ),),
                              ):Container(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  // final newUser = UserModel(
                  //     userId.toString(),
                  //     firstNameController.text,
                  //     lastNameController.text,
                  //     dLController.text,
                  //     aCController.text);
                  // createUser(newUser);
                  uploadFile();
                },
                child: Container(
                  child: Center(
                    child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Icon(Icons.arrow_forward_ios_outlined)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDoneDialog(text, isComplete) => showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          isComplete== true?Lottie.asset("lib/assets/animations/done.json",
              repeat: false,
              controller: sucessfullAnimationController,
              onLoaded: (composition){
                sucessfullAnimationController.duration = composition.duration;
                sucessfullAnimationController.forward();
              }
          ):
          Lottie.asset("lib/assets/animations/error.json",
              repeat: false,
              controller: unsucessfullAnimationController,
              onLoaded: (composition){
                unsucessfullAnimationController.duration = composition.duration;
                unsucessfullAnimationController.forward();
              }
          ),
          Text(text,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    ),
  );
}
