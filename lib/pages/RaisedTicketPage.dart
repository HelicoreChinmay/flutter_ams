import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_ams/raised_ticketmodel.dart';
import 'package:flutter_web_image_picker/flutter_web_image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;

class RaisedTicketPage extends StatefulWidget {
  @override
  _MyRaisedTicketPage createState() => _MyRaisedTicketPage();
}

enum Department { Finance }

class _MyRaisedTicketPage extends State<RaisedTicketPage> {
  var errorMsg;

  RaisedTicketModel ticket;

  List<int> resource;

  final _formKeyRaisedTicket = new GlobalKey<FormState>();
  TextEditingController departmentController = TextEditingController();
  TextEditingController ideaController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  Future<Department> departmentChoiceDialog(BuildContext context) async {
    return await showDialog<Department>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select Department '),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, Department.Finance);
                  departmentController.text = "Finance";
                },
                child: const Text('Finance'),
              ),
            ],
          );
        });
  }

  File imgFile;
  Image pickedImage;
  Image image;
  final imgPicker = ImagePicker();

  GlobalKey _key = new GlobalKey();

  bool inside = false;
  Uint8List imageInMemory;
  File _selectedFile;
  bool inProcess = false;

  String base64Image;

  Future<RaisedTicketModel> addRaisedTicket(String username,
      String descripation, String idea, String price, String image) async {
    final String apiUrl = "https://ossms.com/management_api/Api/insert";

    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode({
        "username": username,
        "descripation": descripation,
        "idea": idea,
        "price": price,
        "image": image,
      }),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );

    print("response.body = ${response.body}");
    print("response = ${response.headers}");

    if (response.statusCode == 200) {
      final String responseString = response.body;

      print("responseString = $responseString");

      //to access error field
      var decodedJson = json.decode(responseString);
      //print("decodedJson = $decodedJson");
      errorMsg = decodedJson['error'];

      //print("Msg = $errorMsg");

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Submit Successfully"),
        backgroundColor: Colors.pink[600],
      ));

      return raisedTicketModelFromJson(responseString);
    } else {
      return null;
    }
  }

  Future<void> showOptionsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Options"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Capture Image From Camera"),
                    onTap: () {
                      //openCamera();
                      getImage(ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  GestureDetector(
                    child: Text("Take Image From Gallery"),
                    onTap: () {
                      //openGallery();
                      getImage(ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget getImageWidget() {
    if (_selectedFile != null) {
      //log("_selectedFile = $_selectedFile");

      _selectedFile.readAsBytesSync();

      base64Image = base64Encode(_selectedFile.readAsBytesSync());

      log("base64ImageValue By User = $base64Image");

      _selectedFile.path.split("/").last;
      return Stack(
        clipBehavior: Clip.none,
        children: [
          RepaintBoundary(
            key: _key,
            child: ClipRRect(
              child: Container(
                  width: 100, height: 100, child: Image.file(_selectedFile)),
            ),
          ),
          Positioned(
            child: InkWell(
                onTap: () {
                  print("camera image clicked");
                  showOptionsDialog(context);
                },
                child: Icon(
                  Icons.edit,
                  size: 40,
                )
                /*child: Image.asset(
                Images.ImgChangeUserProfile,
                scale: 0.1,
              ),*/
                ),
            right: 0,
            top: 72,
            bottom: 0,
            left: 1,
          ),
        ],
      );
    } else {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          //resource == null ? Text("resource null") : Text("resource not null"),
          //toBase64EditProfile != null ? Text("not null") : Text("null"),
          resource != null
              ? ClipRRect(
                  child: Container(
                    width: 100,
                    height: 100,
                    child: Image.memory(
                      resource,
                    ),
                  ),
                )
              : InkWell(
                  onTap: () async {
                    if (kIsWeb) {
                      // running on the web!

                      log("Flutter is running on the web");

                      final _image = await FlutterWebImagePicker.getImage;
                      print("_image = $_image");
                      setState(() {
                        image = _image;
                        print("image = $image");
                      });
                    } else {
                      // NOT running on the web! You can check for additional platforms here.
                      log("Flutter is running on not in web");
                      print("camera image clicked");
                      showOptionsDialog(context);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(),
                    width: 100,
                    height: 30,
                    child: Icon(
                      Icons.add_circle_outline,
                      size: 30,
                      color: Colors.grey,
                    ),
                  ),
                ),
          /*CircleAvatar(
                  radius: 60.0,
                  backgroundImage: ExactAssetImage(Images.ImgNoUserProfileJpg),
                ),*/
          Positioned(
            child: Text(""),
            right: 0,
            top: 72,
            bottom: 0,
            left: 1,
          ),
        ],
      );
    }
  }

  getImage(ImageSource source) async {
    this.setState(() {
      inProcess = true;
    });
    File image = await ImagePicker.pickImage(source: source);
    if (image != null) {
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.png,
          androidUiSettings: AndroidUiSettings(
            statusBarColor: Colors.black,
            backgroundColor: Colors.white,
          ));

      this.setState(() {
        _selectedFile = cropped;
        inProcess = false;
      });
    } else {
      this.setState(() {
        inProcess = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Form(
          key: _formKeyRaisedTicket,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Container(
                  height: 70,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: new Color(0xffFBFBFB),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 24.0, 20.0, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //screenWidth < 280 ?
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: Colors.pink[400],
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                        screenWidth < 280
                            ? Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5.0),
                                          child: Text(
                                            "Raised Ticket",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : Expanded(
                                flex: 2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text(
                                        "Raised Ticket",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        Expanded(
                          flex: 1,
                          child: Text(""),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                color: new Color(0xffDBDBDB),
                height: 0.1,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: ColoredBox(
                      color: new Color(0xffFAFAFA),
                      //color: Colors.amber,
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(26.0, 12.0, 8.0, 12.0),
                        child: RichText(
                          text: TextSpan(
                            text: "Raised By ",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: new Color(0xffA0A0A0),
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "*",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.pink[600],
                                      fontSize: 16.0)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: ColoredBox(
                      //color: new Color(0xffFAFAFA),
                      color: Colors.white,
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(14.0, 12.0, 8.0, 12.0),
                        child: Text(
                          "Chinmay",
                          style: TextStyle(fontSize: 16.0, color: Colors.grey),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Divider(
                color: new Color(0xffDBDBDB),
                height: 0.1,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: ColoredBox(
                      color: new Color(0xffFAFAFA),
                      //color: Colors.amber,
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(26.0, 12.0, 8.0, 12.0),
                        child: RichText(
                          textAlign: TextAlign.end,
                          text: TextSpan(
                            text: "Idea ",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "*",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.pink[600],
                                      fontSize: 16.0)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      controller: ideaController,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      textInputAction: TextInputAction.next,
                      validator: RequiredValidator(errorText: "* Required"),
                      decoration: new InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: ""),
                    ),
                  ),
                ],
              ),
              Divider(
                color: new Color(0xffDBDBDB),
                height: 0.01,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: ColoredBox(
                      color: new Color(0xffFAFAFA),
                      //color: Colors.amber,
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 12.0, 8.0, 12.0),
                        child: RichText(
                          text: TextSpan(
                            text: "Department ",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "*",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.pink[600],
                                      fontSize: 16.0)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                      enableInteractiveSelection: false,
                      readOnly: true,
                      controller: departmentController,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      textInputAction: TextInputAction.next,
                      validator: RequiredValidator(errorText: "* Required"),
                      onTap: () {
                        departmentChoiceDialog(context);
                      },
                      decoration: new InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: ""),
                    ),
                  ),
                ],
              ),
              Divider(
                color: new Color(0xffDBDBDB),
                height: 0.01,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: ColoredBox(
                      color: new Color(0xffFAFAFA),
                      //color: Colors.amber,
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(19.0, 12.0, 8.0, 12.0),
                        child: RichText(
                          text: TextSpan(
                            text: "Description ",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "*",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.pink[600],
                                      fontSize: 16.0)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                      controller: descriptionController,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      validator: RequiredValidator(errorText: "* Required"),
                      maxLines: 4,
                      decoration: new InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: ""),
                    ),
                  ),
                ],
              ),
              Divider(
                color: new Color(0xffDBDBDB),
                height: 0.01,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: ColoredBox(
                      color: new Color(0xffFAFAFA),
                      //color: Colors.amber,
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(21.0, 12.0, 8.0, 12.0),
                        child: RichText(
                          textAlign: TextAlign.end,
                          text: TextSpan(
                            text: "Price ",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "*",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.pink[600],
                                      fontSize: 16.0)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                      controller: priceController,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      textInputAction: TextInputAction.next,
                      decoration: new InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: ""),
                    ),
                  ),
                ],
              ),
              Divider(
                color: new Color(0xffDBDBDB),
                height: 0.01,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Upload Attachment :",
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 20.0),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getImageWidget(),
                    image != null ? image : Text('No data...')
                  ],
                ),
              ),
              SizedBox(height: 50.0),
              Divider(
                color: new Color(0xffDBDBDB),
                height: 0.1,
              ),
              Center(
                child: Container(
                  width: screenWidth,
                  height: 50,
                  color: Colors.white,
                  child: TextButton(
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          color: Colors.pink,
                          fontSize: 14,
                          fontFamily: 'Metropolis-Medium'),
                    ),
                    onPressed: () async {
                      final String username = "Chinmay ";
                      final String descripation = descriptionController.text;
                      final String idea = ideaController.text;
                      final String price = priceController.text;
                      String image = base64Image;

                      log("uploaded IMAGE = $image");

                      if (_formKeyRaisedTicket.currentState.validate()) {
                        final RaisedTicketModel raisedTicketModel =
                            await addRaisedTicket(
                                username, descripation, idea, price, image);

                        print("Ticket Submitted");

                        setState(() {
                          ticket = raisedTicketModel;
                        });

                        descriptionController.text = "";
                        ideaController.text = "";
                        priceController.text = "";
                      } else {}
                    },
                  ),
                ),
              ),
              Divider(
                color: new Color(0xffDBDBDB),
                height: 0.1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
