import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/modals/profileModal/userInfo.dart';
import 'package:flutter_app/screens/UserListPage.dart';
import 'package:flutter_app/widgets/userListWidgets/editUsers.dart';
import '../../services/profileServices/getuserList.dart';
import 'dart:ui';

// ignore: must_be_immutable
class EventCard extends StatelessWidget {
  final List<UserInfo> usersData;
  final int index;
  final VoidCallback onTap;

  EventCard({
    this.usersData,
    this.index,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
      child: Card(
        elevation: 10.0,
        child: Column(children: <Widget>[
          Row(children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0),
                child: Container(
                  width: 70.0,
                  height: 70.0,
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: (usersData[index].userImage != 'none')
                      ? Image.network(
                          'http://10.0.2.2/TourMendWebServices/Images/profileImages/${usersData[index].userImage}',
                          height: 100,
                          width: 130,
                          fit: BoxFit.cover,
                        )
                      : Icon(Icons.verified_user),
                )),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        "Name: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.grey[600]),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2.0, bottom: 5.0),
                      child: Text(
                        usersData[index].userName,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.0,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
                      child: Text(
                        "Email: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.grey[600]),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 5.0, top: 2.0, bottom: 5.0),
                      child: Text(
                        usersData[index].userEmail,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.0,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ]),
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
                    _showPopupMenu(),
                    Padding(
                      padding: EdgeInsets.only(left: 190.0, right: 0),
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        onPressed: () => {
                          (usersData[index].status != 'inactive')
                              ? showInactiveDialog(context)
                              : showActiveDialog(context),
                        },
                        color: (usersData[index].status != 'inactive')
                            ? Colors.blue
                            : Colors.red,
                        child: Row(
                          // Replace with a Row for horizontal icon + text
                          children: <Widget>[
                            (usersData[index].status != 'inactive')
                                ? Text("Active")
                                : Text(usersData[index].status),
                            (usersData[index].status != 'inactive')
                                ? Icon(Icons.check_box)
                                : Icon(Icons.closed_caption_disabled_sharp),
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

  Widget _showPopupMenu() {
    return PopupMenuButton(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      icon: Icon(Icons.more_horiz),
      itemBuilder: (context) {
        return menuItems.map((MenuItem menuItem) {
          return PopupMenuItem(
              child: ListTile(
            // material button or custom list tile
            contentPadding: EdgeInsets.all(0.0),
            dense: true,
            leading: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
              child: Icon(
                menuItem.icon,
                size: 20.0,
                color: (menuItem.menu == 'Delete')
                    ? Colors.redAccent
                    : Colors.blue,
              ),
            ),
            onTap: () => {
              Navigator.of(context).pop(),
              (menuItem.menu == 'Delete')
                  ? showAlertDialog(context)
                  : showEditDialog(context),
            },
            title: Text(
              menuItem.menu,
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
          ));
        }).toList();
      },
    );
  }

  showEditDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop(false);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Edit"),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditUsers(
                      usersData: usersData[index],
                    )));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Edit Menu"),
      content: Text("Would you like to Edit Users Details?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showActiveDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop(false);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Active"),
      onPressed: () {
        _active(context);
        Navigator.of(context).pop(false);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Active"),
      content: Text("Would you like to Active this Account?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showInactiveDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop(false);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Inactive"),
      onPressed: () {
        _active(context);
        Navigator.of(context).pop(false);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Inactive"),
      content: Text("Would you like to Inactive this account?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop(false);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Delete"),
      onPressed: () {
        _delete(context);
        Navigator.of(context).pop(false);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete"),
      content: Text("Would you like to delete users?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _delete(BuildContext context) async {
    FetchUsers.deleteUsers(usersData[index].id).then((result) {
      print(result);
      // ignore: unrelated_type_equality_checks
      if (result == '1') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Delete successfully!'),
              actions: <Widget>[
                // ignore: deprecated_member_use
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    this.onTap();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error while Deleting profile!'),
              actions: <Widget>[
                // ignore: deprecated_member_use
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  void _active(BuildContext context) async {
    FetchUsers.activeUsers(usersData[index].id, usersData[index].status)
        .then((result) {
      print(result);
      print(usersData[index].status);
      // ignore: unrelated_type_equality_checks
      if (result == '1') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Operation successfull!'),
              actions: <Widget>[
                // ignore: deprecated_member_use
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    this.onTap();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error while  Activation/Deactivation!'),
              actions: <Widget>[
                // ignore: deprecated_member_use
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }
}

class MenuItem {
  String menu;
  IconData icon;

  MenuItem(this.menu, this.icon);
}

final List<MenuItem> menuItems = [
  MenuItem(
    'Edit',
    Icons.edit,
  ),
  MenuItem('Delete', Icons.delete),
];
