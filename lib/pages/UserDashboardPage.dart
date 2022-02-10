import 'package:flutter/material.dart';
import 'package:flutter_ams/pages/RaisedTicketPage.dart';
import 'package:flutter_ams/pages/UserRaisedTicketsListPage.dart';

class UserDashboardPage extends StatefulWidget {
  @override
  _MyHomePageScreen createState() => _MyHomePageScreen();
}

class _MyHomePageScreen extends State<UserDashboardPage> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(20.0, 5.0, 0.0, 0.0),
                          child: Text(
                            "User Dashboard",
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
                ),
              ),
              Divider(
                color: new Color(0xffDBDBDB),
                height: 0.1,
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 12.0),
                      child: Text(
                        'Raised Ticket',
                        style: TextStyle(
                            color: new Color(0xff0B4328),
                            fontSize: 14,
                            fontFamily: 'Metropolis-Medium'),
                      ),
                    ),
                    style: TextButton.styleFrom(
                      side: BorderSide(color: Color(0xff0B4328), width: 1),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RaisedTicketPage()));
                    },
                  ),
                  TextButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 12.0),
                      child: Text(
                        'View Ticket Details',
                        style: TextStyle(
                            color: new Color(0xff0B4328),
                            fontSize: 14,
                            fontFamily: 'Metropolis-Medium'),
                      ),
                    ),
                    style: TextButton.styleFrom(
                      side: BorderSide(color: Color(0xff0B4328), width: 1),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserRaisedTicketsListPage()));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
