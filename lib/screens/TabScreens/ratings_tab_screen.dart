import 'package:flutter/material.dart';

class RatingsTabScreen extends StatelessWidget {
  final Map<String, dynamic> userData;
  const RatingsTabScreen(this.userData);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).primaryColorDark,
            ),
            padding: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 50),
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Text("Your Rating",
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star_border,
                      size: 60,
                      color: Colors.yellow,
                    ),
                    Icon(Icons.star_border,
                      size: 60,
                      color: Colors.yellow,
                    ),
                    Icon(Icons.star_border,
                      size: 60,
                      color: Colors.yellow,
                    ),
                    Icon(Icons.star_border,
                      size: 60,
                      color: Colors.yellow,
                    ),
                    Icon(Icons.star_border,
                      size: 60,
                      color: Colors.yellow,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
