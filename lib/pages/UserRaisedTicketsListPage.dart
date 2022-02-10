import 'dart:developer';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_ams/pages/UserTicketDetailsPage.dart';
import 'package:http/http.dart' as http;

class UserRaisedTicketsListPage extends StatefulWidget {
  @override
  _MyHomePageScreen createState() => _MyHomePageScreen();
}

class _MyHomePageScreen extends State<UserRaisedTicketsListPage> {
  List<int> resource;

  var id;
  var index = 0;
  var data;
  var langSelectLength;
  
  Future getAllTicketList() async {
    http.Response response = await http
        .get(Uri.parse("https://ossms.com/management_api/Api/get_tickets/"));

    if (response.statusCode == 200) {
      data = response.body; //store response as string

      setState(() {
        langSelectLength =
            jsonDecode(data)['data']; //get all the data from json string

        print(langSelectLength.length); // just printed length of data

        log("response = $data");
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Column(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5.0),
                                            child: Text(
                                              "All Raised Tickets",
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
                                        padding:
                                            const EdgeInsets.only(top: 5.0),
                                        child: Text(
                                          "All Raised Tickets",
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
                getHomePageBody(context),
                SizedBox(height: 20.0)
              ],
            ),
          ],
        ),
      ),
    );
  }

  getHomePageBody(BuildContext context) {

    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: <Widget>[
          langSelectLength == null
              ? AwesomeLoader(
                  loaderType: AwesomeLoader.AwesomeLoader3,
                  color: Colors.pink[600],
                )
              : ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      langSelectLength == null ? 0 : langSelectLength.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        print(
                            "TicketID = ${jsonDecode(data)['data'][index]['id']}");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserTicketDetailsPage(
                                    jsonDecode(data)['data'][index]['id'].toString())));
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(26.0, 0.0, 26.0, 3.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  jsonDecode(data)['data'][index]['username'],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      fontFamily: 'Roboto-Regular'),
                                ),
                              ],
                            ),
                            SizedBox(height: 3.0),
                            Row(
                              children: <Widget>[
                                Text(
                                  jsonDecode(data)['data'][index]['idea'],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: 'Roboto-Regular'),
                                ),
                              ],
                            ),
                            SizedBox(height: 3.0),
                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    jsonDecode(data)['data'][index]
                                        ['descripation'],
                                    style: TextStyle(
                                        color: Color(0XFF979797),
                                        fontSize: 14,
                                        fontFamily: 'Roboto-Regular'),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Divider(
                              height: 1,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 8.0,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getAllTicketList();
  }
}
