import 'package:flutter/material.dart';
import 'package:flutter_app/modals/profileModal/adminInfo.dart';

class EventCard extends StatelessWidget {
  final List<AdminInfo> adminsData;
  final int index;

  EventCard({
    this.adminsData,
    this.index,
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
                  child: Image.network(
                    'http://10.0.2.2/TourMendWebServices/Images/profileImages/${adminsData[index].adminImage}',
                    height: 100,
                    width: 130,
                    fit: BoxFit.cover,
                  ),
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
                        adminsData[index].adminName,
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
                        adminsData[index].adminEmail,
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
                    Padding(
                      padding: EdgeInsets.only(left: 250.0, right: 0),
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        onPressed: () => {},
                        color: Colors.blue,
                        child: Row(
                          // Replace with a Row for horizontal icon + text
                          children: <Widget>[
                            Text("Active"),
                            Icon(Icons.check_box),
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
}
