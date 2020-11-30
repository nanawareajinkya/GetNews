import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              "Ajinkya Nanaware", style: TextStyle(
              fontFamily: "Satisfy",
              fontSize: 20
            ),
            ),
            accountEmail: Text(
              "Nanawareajinkya46@gmail.com",
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/aj.jpg'),
            ),
            otherAccountsPictures: <Widget>[
              CircleAvatar(
                child: Text(
                  "AJ",
                ),
                backgroundColor: Colors.grey[900],
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text(
              "Home",
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            /*onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
              ));
            },*/
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              "Settings",
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
