import 'dart:typed_data';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ams/approval_model.dart';
import 'package:flutter_ams/pages/ImageFullSize.dart';
import 'package:flutter_ams/rejectTicket_model.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'dart:convert';
import 'package:flutter_switch/flutter_switch.dart';

class ManagerTicketDetailsPage extends StatefulWidget {
  final String ticketId;
  ManagerTicketDetailsPage(this.ticketId, {Key key}) : super(key: key);

  @override
  _MyManagerTicketDetailsPageState createState() =>
      _MyManagerTicketDetailsPageState();
}

class _MyManagerTicketDetailsPageState extends State<ManagerTicketDetailsPage> {
  ApprovalModel approval;

  RejectTicketModel rejectTicket;

  var getManagerApproval;
  var getFinanceApproval;
  var getCeoApproval;

  var managerApproval;
  var financeApproval;
  var ceoApproval;
  var data;
  var langSelectLength;
  var errorMsg;

  bool isSwitched = false;

  Uint8List imageInMemory;

  String base64Image;

  var resource;
  var toBase64EditProfile;

  Future<ApprovalModel> giveApproval(String id, String approve_by) async {
    final String apiUrl =
        "https://ossms.com/management_api/Api/approve_ticket/";

    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode({
        "id": id,
        "approve_by": approve_by,
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

      //return raisedTicketModelFromJson(responseString);
      return approvalModelFromJson(responseString);
    } else {
      return null;
    }
  }

  Future<RejectTicketModel> rejectApproval(String id, String reject_by) async {
    final String apiUrl = "https://ossms.com/management_api/Api/reject_ticket/";

    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode({
        "id": id,
        "reject_by": reject_by,
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

      return rejectTicketModelFromJson(responseString);
    } else {
      return null;
    }
  }

  void getTicketDetails() async {
    print("Widget.ticketId = ${widget.ticketId}");

    http.Response response = await http.get(Uri.parse(
        "https://ossms.com/management_api/Api/get_ticket_detail/${widget.ticketId}/"));

    if (response.statusCode == 200) {
      data = response.body; //store response as string

      //print("response = $data");

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
          isSwitched = true;
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
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  20.0, 8.0, 8.0, 8.0),
                              child: Text(
                                "Give Approval",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  16.0, 8.0, 0.0, 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  FlutterSwitch(
                                    value: isSwitched,
                                    activeColor: Colors.pink[600],
                                    onToggle: (val) {
                                      setState(() {
                                        isSwitched = val;
                                        print("isSwitched = $val");
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
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
                                print("isSwitched = $isSwitched");

                                if (isSwitched == true) {
                                  final String id = "${widget.ticketId}";
                                  final String approve_by = "2";
                                  final ApprovalModel approvalModel =
                                      await giveApproval(id, approve_by);

                                  setState(() {
                                    approval = approvalModel;
                                  });
                                } else if (isSwitched == false) {
                                  final String id = "${widget.ticketId}";
                                  final String approve_by = "2";
                                  final RejectTicketModel rejectTicketModel =
                                      await rejectApproval(id, approve_by);

                                  setState(() {
                                    rejectTicket = rejectTicketModel;
                                  });

                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ManagerTicketDetailsPage(
                                                  widget.ticketId)));
                                }
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
