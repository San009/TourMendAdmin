import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/userListWidgets/addUser.dart';
import '../modals/profileModal/userInfo.dart';
import '../services/profileServices/getuserList.dart';
import '../services/getUserInfo.dart';
import '../widgets/userListWidgets/userCard.dart';
import '../widgets/jsonListViewWidget/jsonListView.dart';

class UsersPage extends StatefulWidget {
  final String title;

  UsersPage({Key key, this.title}) : super(key: key);
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<UsersPage> {
  SharedPreferences preferences;
  List<UserInfo> eventsData;
  ScrollController _scrollController;
  int _pageNumber;
  bool _isLoading, _showButton;
  String userImage;
  //StreamController<List<String>> yourStream = StreamController<List<String>>();
  bool _showSearchBar;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    eventsData = [];

    _showSearchBar = true;
    _pageNumber = 1;
    _isLoading = true;
    _showButton = true;

    _fetchEvents().then((result) {
      if (result != null) {
        setState(() {
          _isLoading = false;
        });
        for (var event in result) {
          eventsData.add(event);
        }
      }
    });

    _scrollController.addListener(() {
      // print(_scrollController.position.extentAfter);
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          _pageNumber++;
        });
        _fetchEvents().then((result) {
          if (result != null) {
            for (var event in result) {
              eventsData.add(event);
            }
          }
        });
      }
    });

    _handleScroll();
    _getUserImage();
    // _getData();
  }

  void _getUserImage() async {
    preferences = await SharedPreferences.getInstance();
    var userEmail = preferences.getString('user_email');

    GetUserInfo.getUserImage(userEmail).then((value) {
      setState(() {
        userImage = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'All Users List',
          style: TextStyle(
            decoration: TextDecoration.none,
            color: Colors.white,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _getData,
        child: Container(
          padding: _showSearchBar
              ? EdgeInsets.only(top: 55.0)
              : EdgeInsets.only(top: 0.0),
          child: FutureBuilder<List<UserInfo>>(
            initialData: eventsData,
            future: _fetchEvents(),
            builder: (context, snapshot) {
              physics:
              BouncingScrollPhysics();

              if (_isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return JsonListView(
                snapshot: snapshot,
                listData: eventsData,
                scrollController: _scrollController,
                childWidget: (value) => EventCard(
                  usersData: eventsData,
                  index: value,
                  onTap: () => _getData(),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: _showButton,
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddUserPage(
                    onTap: () => _getData(),
                  ),
                ));
          },
          label: Text(
            'Add Users',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }

  Future<List<UserInfo>> _fetchEvents() {
    return FetchUsers.fetchUsers(pageNumber: _pageNumber)
        .then((value) => value.users);
  }

  Future<void> _getData() async {
    setState(() {
      eventsData.clear();
      _pageNumber = 1;
      _fetchEvents().then((result) {
        if (result != null) {
          setState(() {
            _isLoading = false;
          });
          for (var event in result) {
            eventsData.add(event);
          }
        }
      });
    });

    print(_pageNumber);

    // ignore: deprecated_member_use
  }

  void _handleScroll() async {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
              ScrollDirection.reverse &&
          _scrollController.position.pixels >= 36) {
        setState(() {
          _showButton = false;
          _showSearchBar = false;
        });
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          _showButton = true;
          _showSearchBar = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
