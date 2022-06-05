import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:mca_project/models/user.dart';
import 'package:mca_project/screens/driver_register_done_page.dart';
import '../models/vehicle.dart';


class VehicleRegisterPage extends StatefulWidget {
  final UserModel? userModel;
  VehicleRegisterPage(this.userModel);

  @override
  State<VehicleRegisterPage> createState() =>
      _VehicleRegisterPageState();
}

class _VehicleRegisterPageState
    extends State<VehicleRegisterPage>
    with TickerProviderStateMixin
{
  @override
  void initState() {
    print(widget.userModel!.firstName);
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
          MaterialPageRoute(builder: (context) => const DriverRegistrationDonePage()),
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

  PlatformFile? front;
  PlatformFile? back;
  PlatformFile? left;
  PlatformFile? right;
  UploadTask? task;
  int? uploadDoc;
  bool isComplete = false;
  VehicleModel? newVehicle;

  late AnimationController sucessfullAnimationController;
  late AnimationController unsucessfullAnimationController;

  final vehicleManufacturerController = TextEditingController();
  final vehicleModelController = TextEditingController();
  final vehicleNumberController = TextEditingController();
  final vehicleColorController = TextEditingController();
  String dropdownvalue = 'Two Wheeler';

  // List of items in our dropdown menu
  var items = [
    'Two Wheeler',
    'Four Wheeler',
  ];

  String dropdownWeight = "2-20 kgs";
  var weightCategory = [
    'Less than 2kgs',
    '2-20 kgs',
    'More than 20kgs'
  ];
  bool showWeightCategory = false;
  @override
  Widget build(BuildContext context) {


    final user = FirebaseAuth.instance.currentUser!;
    final userId = user.phoneNumber;

    Future createVehicle(VehicleModel? newVehicle) async {
      //reference the document
      final docUser =
      FirebaseFirestore.instance.collection('drivers').doc(userId);
      final json = newVehicle!.toJson();
      await docUser.update(json);
      //create document and write data to Firestore
    }
    Future createUser(UserModel? newUser) async {
      //reference the document
      final docUser =
      FirebaseFirestore.instance.collection('drivers').doc(userId);
      final json1 = newUser!.toJson();

      await docUser.set(json1);
      //create document and write data to Firestore
    }

    Future createUserAndVehicle(UserModel? newUser, VehicleModel? newVehicle) async {
      //reference the document
      final docUser =
      FirebaseFirestore.instance.collection('drivers').doc(userId);
      final json1 = newUser!.toJson();
      final json2 = newVehicle!.toJson();
      await docUser.set(json1).then((value) => docUser.update(json2));
      //create document and write data to Firestore
    }


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
            front = result.files.first
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
            back = result.files.first
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
            left = result.files.first
          });
        }
      }
      if(uploadDoc == 3)
      {
        final result = await FilePicker.platform.pickFiles(allowMultiple: false);
        if (result == null) {
          return;
        } else {
          final path = result.files.single.path!;
          setState(() =>
          {
            right = result.files.first
          });
        }
      }
    }

    Future uploadFile() async{
      var d = front;
      var a = back;
      var l = left;
      var r = right;
      if(d!=null && a!=null && l!=null &&r!=null)
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
            final path = '$userId/Car Front';
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
            final path = '$userId/Car Back';
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
            final path = '$userId/Car Left';
            final ref = FirebaseStorage.instance.ref().child(path);
            task = ref.putFile(file);
            setState(() {

            });

          }
          if(r == null && uploadDoc == 3)
          {
            return;
          }
          else
          {
            final file = File(r.path!);
            final path = '$userId/Car Right';
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
        createUserAndVehicle(widget.userModel, newVehicle);
        // createVehicle(newVehicle);
        // createUser(widget.userModel);
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
                "Register Your Vehicle",
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
                                TextFormField(
                                controller: vehicleManufacturerController,
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
                                  labelText: 'Vehicle Manufacturer',
                                  labelStyle: TextStyle(
                                    color: Color(0xFF6200EE),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: vehicleModelController,
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
                                  labelText: 'Vehicle Model',
                                  labelStyle: TextStyle(
                                    color: Color(0xFF6200EE),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: vehicleNumberController,
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
                                  labelText: "Vehicle Number",
                                  labelStyle: TextStyle(
                                    color: Color(0xFF6200EE),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: vehicleColorController,
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
                                  labelText: 'Vehicle Color',
                                  labelStyle: TextStyle(
                                    color: Color(0xFF6200EE),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text("Select Vehicle Type: ",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),),
                              DropdownButton(
                                style: TextStyle(
                                  color: Theme.of(context).primaryColorDark
                                ),
                                // Initial Value
                                value: dropdownvalue,

                                // Down Arrow Icon
                                icon: const Icon(Icons.keyboard_arrow_down),

                                // Array list of items
                                items: items.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownvalue = newValue!;
                                    print(dropdownvalue);
                                    showWeightCategory = true;
                                  });
                                },
                              ),
                              showWeightCategory == true? DropdownButton(
                                style: TextStyle(
                                    color: Theme.of(context).primaryColorDark
                                ),
                                // Initial Value
                                value: dropdownWeight,

                                // Down Arrow Icon
                                icon: const Icon(Icons.keyboard_arrow_down),

                                // Array list of items
                                items: weightCategory.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                // After selecting the desired option,it will
                                // change button value to selected value
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownWeight = newValue!;
                                    print(dropdownWeight);
                                  });
                                },
                              ): Container(),
                              SizedBox(
                                height: 10,
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
                                      "Vehicle Images",
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
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.red,
                                      ),
                                      onPressed: () async {
                                        uploadDoc = 0;
                                        selectFile();
                                      },
                                      child: Container(
                                          height: 75,
                                          child: Center(
                                              child: Text(
                                                "Front",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ))),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.red,
                                      ),
                                      onPressed: () {
                                        uploadDoc = 1;
                                        selectFile();
                                      },
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Container(
                                            height: 75,
                                            child: Center(
                                                child: Text(
                                                  "Back",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                ))),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.red,
                                      ),
                                      onPressed: () async {
                                        uploadDoc = 2;
                                        selectFile();
                                      },
                                      child: Container(
                                          height: 75,
                                          child: Center(
                                              child: Text(
                                                "Left",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ))),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.red,
                                      ),
                                      onPressed: () {
                                        uploadDoc = 3;
                                        selectFile();
                                      },
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Container(
                                            height: 75,
                                            child: Center(
                                                child: Text(
                                                  "Right",
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold),
                                                ))),
                                      ),
                                    ),
                                  ),

                                ],
                              ),

                              front != null?Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text("Front : " +front!.name,style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12
                                ),),
                              ):Container(),
                              back!= null?Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text("Back : " +back!.name,style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12
                                ),),
                              ):Container(),
                              left!= null?Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text("Left : " +left!.name,style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12
                                ),),
                              ):Container(),
                              right!= null?Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text("Right : " +right!.name,style: TextStyle(
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
                  newVehicle = VehicleModel(
                      userId.toString(),
                      vehicleManufacturerController.text,
                      vehicleModelController.text,
                      vehicleNumberController.text,
                      vehicleColorController.text,
                      dropdownvalue,
                  );
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

