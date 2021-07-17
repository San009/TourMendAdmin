import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/modals/placesModal/places.dart';
import 'package:flutter_app/services/placeServices/updateImage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'actionButtions copy.dart';
import '../../services/placeServices/addPlaceServices.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EditPlaces extends StatefulWidget {
  final String title;
  final PlacesData placeData;

  EditPlaces({Key key, this.title, this.placeData}) : super(key: key);
  @override
  EditPlaceState createState() => EditPlaceState();
}

class EditPlaceState extends State<EditPlaces>
    with SingleTickerProviderStateMixin {
  TextEditingController _placename;
  TextEditingController _desname;
  TextEditingController _info;
  TextEditingController _itinerary;

  GlobalKey<FormState> _formKey;
  final picker = ImagePicker();
  File _image;
  File _imageP;
  String base64Image;
  @override
  void initState() {
    _placename = TextEditingController(text: widget.placeData.name);
    _desname = TextEditingController(text: widget.placeData.destination);
    _info = TextEditingController(text: widget.placeData.info);
    _itinerary = TextEditingController(text: widget.placeData.itinerary);
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  void _clearValues() {
    _placename.text = '';
    _desname.text = '';
    _info.text = '';
    _itinerary.text = '';
  }

  clearimage() {
    setState(() {
      _image = null;
      _imageP = null;
    });
  }

  void _updatefield() async {
    FormService.editPlace(
      widget.placeData.id,
      _placename.text,
      _desname.text,
      _info.text,
      _itinerary.text,
      _imageP,
      _image,
    ).then((result) {
      print(result);
      if (result == '1') {
        _clearValues();
        clearimage();
        _showDialog(context, 'Place Added\n Successfully.');
      } else if (result == '0') {
        // _clearValues();
        _showDialog(context, 'Error while editing place!');
      } else {
        _showDialog(context, 'Select All Images');
      }
    });
  }

  void _updatePlaceImage() async {
    ImageService.updatePI(
      widget.placeData.id,
      _imageP,
    ).then((result) {
      print(result);
      if (result == '1') {
        clearimage();
        _showDialog(context, 'Place image uploaded\n Successfully.');
      } else if (result == '0') {
        // _clearValues();
        _showDialog(context, 'Error while uploading!');
      } else {
        _showDialog(context, 'Error in method');
      }
    });
  }

  void _updateMapImage() async {
    ImageService.updateMI(
      widget.placeData.id,
      _image,
    ).then((result) {
      print(result);
      if (result == '1') {
        clearimage();
        _showDialog(context, 'map uploaded\n Successfully.');
      } else if (result == '0') {
        // _clearValues();
        _showDialog(context, 'Error while uploading!');
      } else {
        _showDialog(context, 'Error in method');
      }
    });
  }

  Future getImage() async {
    // ignore: deprecated_member_use
    var image = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image.path);
      print(_image);
    });
  }

  Future getImageP() async {
    // ignore: deprecated_member_use
    var image = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _imageP = File(image.path);
      // print(_image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Edit Places',
          style: TextStyle(
            decoration: TextDecoration.none,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            textSection(),
          ],
        ),
      ),
    );
  }

  Form textSection() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.only(bottom: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Place Name *',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 9.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Flexible(
                      child: TextFormField(
                        controller: _placename,
                        validator: (value) =>
                            value.isEmpty ? 'Place name is required!' : null,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          hintText: 'Enter place name',
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(5.0),
                            ),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Destination Name *',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 9.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Flexible(
                      child: TextFormField(
                        controller: _desname,
                        validator: (value) => value.isEmpty
                            ? 'Destination name is required!'
                            : null,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          hintText: 'Enter Destination name',
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(5.0),
                            ),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Info *',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 9.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Flexible(
                        child: TextFormField(
                      controller: _info,
                      validator: (value) =>
                          value.isEmpty ? 'Info is required!' : null,
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,
                      maxLines: 10,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        hintText: 'Write here',
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(5.0),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                    )),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Itinerary *',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 9.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Flexible(
                        child: TextFormField(
                      controller: _itinerary,
                      validator: (value) =>
                          value.isEmpty ? 'Itinerary is required!' : null,
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,
                      maxLines: 10,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        hintText: 'Write here',
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(5.0),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                    )),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Place Image *',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                )),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Stack(fit: StackFit.loose, children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 90,
                    child: ClipOval(
                      child: SizedBox(
                        width: 180.0,
                        height: 180.0,
                        child: (_image != null)
                            ? Image.file(
                                _imageP,
                                fit: BoxFit.fill,
                              )
                            : Image.network(
                                'http://10.0.2.2/TourMendWebServices/Images/places/${widget.placeData.image}',
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 110.0, left: 140.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            radius: 25.0,
                            child: IconButton(
                              icon: Icon(
                                Icons.camera_alt,
                                size: 30.0,
                              ),
                              onPressed: () {
                                getImageP();
                              },
                            ))
                      ],
                    )),
              ]),
            ),
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 9.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // ignore: deprecated_member_use
                    FlatButton(
                      onPressed: () => {_updatePlaceImage()},
                      color: Colors.blue,
                      child: Row(
                        // Replace with a Row for horizontal icon + text
                        children: <Widget>[
                          Text("Upload"),
                          Icon(Icons.camera_alt),
                        ],
                      ),
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Map *',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                )),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Stack(fit: StackFit.loose, children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 90,
                    child: ClipOval(
                      child: SizedBox(
                        width: 180.0,
                        height: 180.0,
                        child: (_image != null)
                            ? Image.file(
                                _image,
                                fit: BoxFit.fill,
                              )
                            : Image.network(
                                'http://10.0.2.2/TourMendWebServices/Images/maps/${widget.placeData.map}',
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 110.0, left: 140.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            radius: 25.0,
                            child: IconButton(
                              icon: Icon(
                                Icons.camera_alt,
                                size: 30.0,
                              ),
                              onPressed: () {
                                getImage();
                              },
                            ))
                      ],
                    )),
              ]),
            ),
            Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 9.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // ignore: deprecated_member_use
                    FlatButton(
                      onPressed: () => {_updateMapImage()},
                      color: Colors.blue,
                      child: Row(
                        // Replace with a Row for horizontal icon + text
                        children: <Widget>[
                          Text("Upload"),
                          Icon(Icons.camera_alt),
                        ],
                      ),
                    ),
                  ],
                )),
            ActionButtons(
              onSave: () {
                if (_formKey.currentState.validate()) {
                  _updatefield();
                }
              },
              onCancel: () => _clearValues(),
            )
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
          actions: <Widget>[
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
}
