import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mca_project/screens/TabScreens/map_tab_screen.dart';
import 'package:mca_project/screens/TabScreens/ratings_tab_screen.dart';

class HomeScreen extends StatelessWidget {
  final String id;
  final Map<String, dynamic> userData;
  const HomeScreen(this.id, this.userData);

  @override
  Widget build(BuildContext context) {
    final firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    Future<firebase_storage.ListResult> listFiles() async {
      firebase_storage.ListResult results =
          await storage.ref("+919864123713").listAll();
      results.items.forEach((firebase_storage.Reference ref) {
        print('found file : $ref');
      });
      return results;
    }

    Future<String> downloadURL(String imageName) async {
      String downloadurl =
          await storage.ref('+919864123713/${imageName}').getDownloadURL();
      return downloadurl;
    }

    print(userData);
    return SafeArea(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [

                MapTabScreen(),
                SingleChildScrollView(
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  "Welcome Back, ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                                Text(
                                  userData['First Name'].toString() +
                                      " " +
                                      userData['Last Name'].toString(),
                                  style: TextStyle(
                                      fontSize: 32, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          FutureBuilder(
                              future: downloadURL('Driver Profile.jpg'),
                              builder: (BuildContext context,AsyncSnapshot<String> snapshot)
                              {
                                if(snapshot.connectionState == ConnectionState.done && snapshot.hasData)
                                {
                                  return Container(
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(200),
                                    ),
                                    child: CircleAvatar(backgroundImage: NetworkImage(snapshot.data!)),
                                  );
                                }
                                return Container(
                                  width: 200,
                                  height: 200,
                                  child: Center(
                                    child: Container(
                                        width: 50,
                                        height: 50,
                                        child: CircularProgressIndicator()),
                                  ),
                                );
                              }

                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text("Personal Details : ", style: TextStyle(
                                    decoration: TextDecoration.underline
                                ),),
                                TextWidgetLarge("Aadhaar Card Number: "+userData["Aadhaar Card Number"].toString()),
                                TextWidgetLarge("Driver's License Number: " +userData["DL number"].toString()),
                                SizedBox(height: 20,),
                                Text("Vehicle Details : ", style: TextStyle(
                                    decoration: TextDecoration.underline
                                ),),
                                TextWidgetLarge("Vehicle Manufacturer: "+userData["Vehicle Manufacturer"].toString()),
                                TextWidgetLarge("Vehicle Model: "+userData["Vehicle Model"].toString()),
                                TextWidgetLarge("Vehicle Number: "+userData["Vehicle Number"].toString()),
                                TextWidgetLarge("Vehicle Color: "+userData["Vehicle Color"].toString()),

                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
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
                                  child: Text("Log Out",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),
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
                ),
                OrderTabView(userData),
                RatingsTabScreen(userData),

              ],
            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.only(top: 6),
              color: Theme.of(context).primaryColorDark,
              child: TabBar(
                labelColor: Theme.of(context).primaryColorDark,
                unselectedLabelColor: Colors.white,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: Colors.white),
                tabs: [
                  Tab(icon: Icon(Icons.account_circle_outlined),text: "Profile",),
                  Tab(icon: Icon(Icons.add_location_alt_outlined),text: "Online",),
                  Tab(icon: Icon(Icons.star_border),text: "Ratings",),
                  Tab(icon: Icon(Icons.directions_car),text: "History",),
                ],
              ),
            )),
      ),
    );
  }
}

class TextWidgetLarge extends StatelessWidget {
  final string;
  TextWidgetLarge(this.string);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(string, style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),),
    );
  }
}

class MapTabView extends StatelessWidget {
  final Map<String, dynamic> userData;
  MapTabView(this.userData);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "Welcome Back \n" +
            userData['First Name'].toString() +
            " " +
            userData['Last Name'].toString(),
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
    );
  }
}

class OrderTabView extends StatelessWidget {
  final Map<String, dynamic> userData;
  OrderTabView(this.userData);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "Welcome Back \n" +
            userData['First Name'].toString() +
            " " +
            userData['Last Name'].toString(),
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
    );
  }
}

class RatingsTabView extends StatelessWidget {
  final Map<String, dynamic> userData;
  RatingsTabView(this.userData);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "Welcome Back \n" +
            userData['First Name'].toString() +
            " " +
            userData['Last Name'].toString(),
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      ),
    );
  }
}
