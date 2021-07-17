import 'package:flutter/material.dart';

// import '../services/profileServices/getUserInfo.dart';
import '../services/fetchAllUsers.dart';
import 'UserListPage.dart';
import 'adminListPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String users, admin;
  void initState() {
    super.initState();
    _getUserInfo();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: new Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: ListView(
                        children: <Widget>[
                          Admin(),
                          Users(),
                          Mod(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget Admin() {
    return Container(
      // padding: EdgeInsets.fromLTRB(15.0, 100.0, 15.0, 450.0),
      child: Card(
        elevation: 10.0,
        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Column(children: <Widget>[
          Column(
            children: <Widget>[
              Row(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 18.0, top: 20.0, bottom: 20.0),
                  child: Icon(
                    Icons.admin_panel_settings,
                    color: Colors.green,
                    size: 70,
                  ),
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 180, top: 15.0),
                      child: (admin == null)
                          ? Text("")
                          : Text(
                              admin,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0,
                                  color: Colors.red),
                              textAlign: TextAlign.right,
                            ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 180.0, bottom: 20.0),
                      child: Text(
                        "Admin",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.grey[700]),
                      ),
                    ),
                  ],
                ),
              ]),
            ],
          ),
          Container(
            padding: EdgeInsets.only(
              left: 15.0,
              right: 5.0,
            ),
            height: 32.0,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 250.0, right: 0),
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdminPage(),
                              ))
                        },
                        color: Colors.blue,
                        child: Row(
                          // Replace with a Row for horizontal icon + text
                          children: <Widget>[
                            Text("See All"),
                            Icon(Icons.arrow_right),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget Users() {
    return Container(
      // padding: EdgeInsets.fromLTRB(15.0, 100.0, 15.0, 450.0),
      child: Card(
        elevation: 10.0,
        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Column(children: <Widget>[
          Column(
            children: <Widget>[
              Row(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 18.0, top: 20.0, bottom: 20.0),
                  child: Icon(
                    Icons.verified_user,
                    color: Colors.green,
                    size: 70,
                  ),
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 180, top: 15.0),
                      child: (users == null)
                          ? Text("")
                          : Text(
                              users,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0,
                                  color: Colors.red),
                              textAlign: TextAlign.right,
                            ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 180.0, bottom: 20.0),
                      child: Text(
                        "Users",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.grey[700]),
                      ),
                    ),
                  ],
                ),
              ]),
            ],
          ),
          Container(
            padding: EdgeInsets.only(
              left: 15.0,
              right: 5.0,
            ),
            height: 32.0,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 250.0, right: 0),
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        onPressed: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UsersPage(),
                              ))
                        },
                        color: Colors.blue,
                        child: Row(
                          // Replace with a Row for horizontal icon + text
                          children: <Widget>[
                            Text("See All"),
                            Icon(Icons.arrow_right),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget Mod() {
    return Container(
      // padding: EdgeInsets.fromLTRB(15.0, 100.0, 15.0, 450.0),
      child: Card(
        elevation: 10.0,
        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Column(children: <Widget>[
          Column(
            children: <Widget>[
              Row(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 18.0, top: 20.0, bottom: 20.0),
                  child: Icon(
                    Icons.supervised_user_circle,
                    color: Colors.green,
                    size: 70,
                  ),
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 180, top: 15.0),
                      child: Text(
                        "3",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                            color: Colors.red),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 180.0, bottom: 20.0),
                      child: Text(
                        "Mod",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.grey[700]),
                      ),
                    ),
                  ],
                ),
              ]),
            ],
          ),
          Container(
            padding: EdgeInsets.only(
              left: 15.0,
              right: 5.0,
            ),
            height: 32.0,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 250.0, right: 0),
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        onPressed: () => {},
                        color: Colors.blue,
                        child: Row(
                          // Replace with a Row for horizontal icon + text
                          children: <Widget>[
                            Text("See All"),
                            Icon(Icons.arrow_right),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  void _getUserInfo() async {
    GetAll.getUsers().then((value) {
      setState(() {
        users = value;
        print(users);
      });
    });

    GetAll.getAdmin().then((value) {
      setState(() {
        admin = value;
      });
    });
  }
}
