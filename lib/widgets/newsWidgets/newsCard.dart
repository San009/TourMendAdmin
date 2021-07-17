import 'package:flutter/material.dart';
import '../../modals/newsModal/news.dart';

class NewsCard extends StatelessWidget {
  final List<NewsData> newsData;
  final int index;

  NewsCard({
    @required this.newsData,
    @required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
      child: Card(
          elevation: 6.0,
          margin: EdgeInsets.only(top: 10.0, bottom: 5.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: <Widget>[
                      (newsData[index].image != 'none')
                          ? Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Image.network(
                                'http://10.0.2.2/TourMendWebServices/Images/news/${newsData[index].image}',
                                height: 100,
                                width: 130,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 90.0,
                        width:
                            (newsData[index].image != 'none') ? 210.0 : 360.0,
                        child: Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(
                            left:
                                (newsData[index].image != 'none') ? 5.0 : 12.0,
                            right:
                                (newsData[index].image != 'none') ? 8.0 : 12.0,
                            top: 10.0,
                          ),
                          child: Text(
                            newsData[index].headLine,
                            maxLines: 3,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              bottom: 10.0,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[500],
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 2.0,
                                      spreadRadius: 0.0)
                                ],
                                border: Border.all(
                                  color: Colors.grey[600],
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 5.0, top: 5.0, left: 8.0),
                                  child: Icon(
                                    Icons.thumb_up,
                                    color: Colors.green,
                                    size: 15,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 5.0,
                                    bottom: 5.0,
                                    top: 5.0,
                                    right: 8.0,
                                  ),
                                  child: Text(
                                    "100k",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                bottom: 10.0, left: 10.0, right: 10.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey[500],
                                      offset: Offset(2.0, 2.0),
                                      blurRadius: 2.0,
                                      spreadRadius: 0.0)
                                ],
                                border: Border.all(
                                  color: Colors.grey[600],
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 5.0, top: 5.0, left: 8.0),
                                  child: Icon(
                                    Icons.mode_comment,
                                    color: Colors.blueAccent,
                                    size: 15,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 5.0,
                                    bottom: 5.0,
                                    top: 5.0,
                                    right: 8.0,
                                  ),
                                  child: Text(
                                    "100k",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
                        _showPopupMenu(),
                        Padding(
                          padding: EdgeInsets.only(left: 190.0, right: 0),
                          // ignore: deprecated_member_use
                          child: FlatButton(
                            onPressed: () => {print(newsData[index].approval)},
                            color: (newsData[index].approval != 'pending')
                                ? Colors.blue
                                : Colors.red,
                            child: Row(
                                // Replace with a Row for horizontal icon + text
                                children: <Widget>[
                                  (newsData[index].approval != 'pending')
                                      ? Text("Approved")
                                      : Text(newsData[index].approval),
                                  (newsData[index].approval != 'pending')
                                      ? Icon(Icons.check_box)
                                      : Icon(
                                          Icons.closed_caption_disabled_sharp),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
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
            onTap: () => {},
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
