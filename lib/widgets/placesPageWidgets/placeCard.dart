import 'package:flutter/material.dart';
import 'package:flutter_app/services/placeServices/fetchPlaces.dart';
import '../../modals/placesModal/places.dart';
import 'editPlaces.dart';

class PlaceCard extends StatelessWidget {
  final List<PlacesData> placesData;
  final int index;
  final VoidCallback onTap;

  PlaceCard({
    @required this.placesData,
    @required this.index,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
      child: Card(
        elevation: 10.0,
        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Image.network(
              'http://10.0.2.2/TourMendWebServices/Images/places/${placesData[index].image}',
              fit: BoxFit.cover,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      left: 15.0,
                      bottom: 10.0,
                    ),
                    child: Text(
                      placesData[index].name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0, bottom: 10.0),
                    child: Text(" | "),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0, bottom: 10.0),
                    child: Text(
                      placesData[index].destination,
                      style: new TextStyle(fontStyle: FontStyle.italic),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              _showPopupMenu(),
            ],
          ),
        ]),
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
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditPlaces(
                placeData: placesData[index],
                //  onTap: () => _getData(),
              ),
            ));
      },
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
    FetchPlaces.deletePlaces(placesData[index].id).then((result) {
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

  Widget _showPopupMenu() {
    return PopupMenuButton(
      padding: const EdgeInsets.only(left: 0.0, bottom: 0.0),
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
