import 'package:flutter/material.dart';
import 'package:flutter_app/modals/eventsModal/events.dart';
import 'package:flutter_app/services/eventServices/fetchEvents.dart';

class EventCard extends StatelessWidget {
  final List<EventsData> eventsData;
  final int index;
  final String userImage;
  final VoidCallback onTap;

  EventCard({
    this.eventsData,
    this.index,
    this.userImage,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
      child: Card(
        elevation: 5.0,
        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 18.0, top: 15.0),
                  child: (userImage == null)
                      ? CircleAvatar(
                          child: Icon(Icons.person),
                          backgroundColor: Colors.blueAccent,
                          radius: 20.0,
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(
                              'http://10.0.2.2/TourMendWebServices/Images/profileImages/${eventsData[index].userImage}'),
                          radius: 20.0,
                        )),
              Padding(
                padding: EdgeInsets.only(left: 10.0, top: 15.0),
                child: Text(
                  'Posted by',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Colors.grey[700]),
                  textAlign: TextAlign.right,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.0, top: 15.0),
                child: Text(
                  eventsData[index].userName,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Colors.black),
                  textAlign: TextAlign.right,
                ),
              ),
            ]),
            Row(
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: (eventsData[index].eventType != 'Other' &&
                          eventsData[index].eventName == 'none')
                      ? Text(
                          eventsData[index].eventType,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19.0,
                          ),
                        )
                      : Text(
                          eventsData[index].eventName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 19),
                          textAlign: TextAlign.right,
                        ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
                  child: Text(
                    "Location : ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.grey[600]),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5.0, top: 2.0, bottom: 5.0),
                  child: Text(
                    eventsData[index].eventAddress,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            (eventsData[index].eventType != 'Other' &&
                    eventsData[index].eventName == 'none')
                ? Container()
                : Row(children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.only(left: 16.0, top: 8.0, bottom: 5.0),
                      child: Text(
                        "Event Date : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.grey[600]),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 8.0, right: 2.0, left: 10.0, bottom: 5.0),
                      child: Text(
                        eventsData[index].fromDate,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.black),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.0, right: 5.0, left: 5.0),
                      child: Text(
                        "to",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.black),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.0, right: 2.0, left: 3.0),
                      child: Text(
                        eventsData[index].toDate,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.black),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ]),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
              child: Row(children: <Widget>[
                Flexible(
                  child: Text(
                    eventsData[index].eventDesc,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                        color: Colors.grey[700]),
                  ),
                ),
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Image.network(
                'http://10.0.2.2/TourMendWebServices/Images/eventsbanner.jpg',
                fit: BoxFit.cover,
              ),
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
                      _showPopupMenu(),
                      Padding(
                        padding: EdgeInsets.only(left: 190.0, right: 0),
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          onPressed: () => {
                            (eventsData[index].approval != 'pending')
                                ? showInactiveDialog(context)
                                : showActiveDialog(context),
                          },
                          color: (eventsData[index].approval != 'pending')
                              ? Colors.blue
                              : Colors.red,
                          child: Row(
                              // Replace with a Row for horizontal icon + text
                              children: <Widget>[
                                (eventsData[index].approval != 'pending')
                                    ? Text("Approved")
                                    : Text(eventsData[index].approval),
                                (eventsData[index].approval != 'pending')
                                    ? Icon(Icons.check_box)
                                    : Icon(Icons.closed_caption_disabled_sharp),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Edit Menu"),
      content: Text("Would you like to Edit Place Details?"),
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
      content: Text("Would you like to delete Place?"),
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
    FetchEvents.deleteEvents(eventsData[index].id).then((result) {
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

  showActiveDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop(false);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Approval"),
      onPressed: () {
        _active(context);
        Navigator.of(context).pop(false);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Approval"),
      content: Text("Would you like to approved this post?"),
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
      child: Text("Pending"),
      onPressed: () {
        _active(context);
        Navigator.of(context).pop(false);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Approval"),
      content: Text("Would you like to kept this post in pending ?"),
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

  void _active(BuildContext context) async {
    FetchEvents.activeEvents(eventsData[index].id, eventsData[index].approval)
        .then((result) {
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
              title: Text('Error in Approving!'),
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
