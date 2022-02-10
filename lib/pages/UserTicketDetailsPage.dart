import 'dart:typed_data';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ams/pages/ImageFullSize.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'dart:convert';

class UserTicketDetailsPage extends StatefulWidget {
  final String ticketId;
  UserTicketDetailsPage(this.ticketId, {Key key}) : super(key: key);

  @override
  _MyRaisedTicketPage createState() => _MyRaisedTicketPage();
}

class _MyRaisedTicketPage extends State<UserTicketDetailsPage> {
  var data;
  var langSelectLength;

  bool inside = false;
  Uint8List imageInMemory;

  var getManagerApproval;
  var getFinanceApproval;
  var getCeoApproval;

  var managerApproval;
  var financeApproval;
  var ceoApproval;

  String base64Image;

  var resource;
  var toBase64EditProfile;

  void getTicketDetails() async {
    print("Widget.ticketId = ${widget.ticketId}");

    http.Response response = await http.get(Uri.parse(
        "https://ossms.com/management_api/Api/get_ticket_detail/${widget.ticketId}/"));

    if (response.statusCode == 200) {
      data = response.body; //store response as string

      print("response = $data");

      setState(() {
        langSelectLength =
            jsonDecode(data)['data']; //get all the data from json string

        print(langSelectLength.length); // just printed length of data

        getManagerApproval = jsonDecode(data)['data']['approve_m'];
        getFinanceApproval = jsonDecode(data)['data']['approve_f'];
        getCeoApproval = jsonDecode(data)['data']['approve_c'];
        base64Image = jsonDecode(data)['data']['image'];

        print("base64Image = $base64Image");

        print("manager_approval = $getManagerApproval");

        if (getManagerApproval == "1") {
          managerApproval = "Approved";
        } else if (getManagerApproval == "2") {
          managerApproval = "Not Approved";
        } else if (getManagerApproval == "0") {
          managerApproval = "Pending";
        }

        if (getFinanceApproval == "1") {
          financeApproval = "Approved";
        } else if (getFinanceApproval == "2") {
          financeApproval = "Not Approved";
        } else if (getFinanceApproval == "0") {
          financeApproval = "Pending";
        }

        if (getCeoApproval == "1") {
          ceoApproval = "Approved";
        } else if (getCeoApproval == "2") {
          ceoApproval = "Not Approved";
        } else if (getCeoApproval == "0") {
          ceoApproval = "Pending";
        }

        print("finance_approval = $getFinanceApproval");
        print("ceo_approval = $getCeoApproval");

        log("response = $data");
      });

      print("Image Found = ${jsonDecode(data)['data']['image']}");
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (base64Image == null) {
      base64Image = "";
    } else {
      var stringToBase64Url = utf8.fuse(base64Url);
      toBase64EditProfile = stringToBase64Url.encode(base64Image);
      resource = base64.decode(base64.normalize(base64Image));
    }

    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Container(
          color: new Color(0xffF2F1F6),
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
                                            "View Ticket Details",
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
                                flex: 3,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20.0, 5.0, 0.0, 0.0),
                                      child: Text(
                                        "View Ticket Details",
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
              langSelectLength == null
                  ? Container(
                      height: screenHeight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Center(
                            child: AwesomeLoader(
                              loaderType: AwesomeLoader.AwesomeLoader3,
                              color: Colors.pink[600],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 40.0,
                              ),
                              Text(
                                "Overview",
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.grey),
                              ),
                              SizedBox(height: 4.0),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0.0, 8.0, 8.0, 8.0),
                                      child: Text(
                                        "Raised By",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          14.0, 8.0, 8.0, 8.0),
                                      child: Text(
                                        "Chinmay",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0.0, 8.0, 8.0, 8.0),
                                      child: Text(
                                        "Idea",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          14.0, 8.0, 8.0, 8.0),
                                      child: Text(
                                        jsonDecode(data)['data']['idea'],
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                color: Colors.white,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8.0, 8.0, 8.0, 8.0),
                                        child: Container(
                                          color: Colors.white,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Description",
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            14.0, 8.0, 8.0, 8.0),
                                        child: Text(
                                          jsonDecode(data)['data']
                                              ['descripation'],
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0.0, 8.0, 8.0, 8.0),
                                      child: Text(
                                        "Price",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          14.0, 8.0, 8.0, 8.0),
                                      child: Text(
                                        "${jsonDecode(data)['data']['price']} ₹",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0.0, 8.0, 8.0, 8.0),
                                      child: Text(
                                        "Manager Approval",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          14.0, 8.0, 8.0, 8.0),
                                      child: Text(
                                        "$managerApproval",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0.0, 8.0, 8.0, 8.0),
                                      child: Text(
                                        "Finance Department Approval",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          14.0, 8.0, 8.0, 8.0),
                                      child: Text(
                                        "$financeApproval",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0.0, 8.0, 8.0, 8.0),
                                      child: Text(
                                        "CEO Approval",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          14.0, 8.0, 8.0, 8.0),
                                      child: Text(
                                        "$ceoApproval",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.0),
                        base64Image != ""
                            ? Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        "Uploaded Attachment",
                                        style: TextStyle(
                                            fontSize: 14.0, color: Colors.grey),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Container(
                                      color: Colors.white,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          base64Image != ""
                                              ? InkWell(
                                                  onTap: () {
                                                    print("Tapp");

                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return ImageFullSizePage(
                                                          resource);
                                                    }));
                                                  },
                                                  child: CircleAvatar(
                                                    radius: 60.0,
                                                    child: ClipRRect(
                                                      child: Image.memory(
                                                          resource),
                                                    ),
                                                  ),
                                                )
                                              : Text("")
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  "This ticket have no attachment",
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.grey),
                                ),
                              ),
                      ],
                    ),
              SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getTicketDetails();
  }
}
