import 'package:flutter/material.dart';
import 'package:flutter_ams/pages/FinanceCompletedTicketListPage.dart';
import 'package:flutter_ams/pages/FinancePendingTicketListPage.dart';
import 'package:flutter_ams/pages/FinanceTicketListPage.dart';

class FinanceDepartmentDashboardPage extends StatefulWidget {
  @override
  _MyFinanceDepartmentDashboardPageState createState() =>
      _MyFinanceDepartmentDashboardPageState();
}

class _MyFinanceDepartmentDashboardPageState
    extends State<FinanceDepartmentDashboardPage> {
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
                            "Finance Dashboard",
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
              Center(
                child: Column(
                  children: [
                    TextButton(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 38.0, vertical: 12.0),
                        child: Text(
                          'Raised Ticket List',
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
                                builder: (context) => FinanceTicketListPage()));
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextButton(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 38.0, vertical: 12.0),
                        child: Text(
                          'Completed Tasks',
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
                                builder: (context) =>
                                    FinanceCompletedTicketListPage()));
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextButton(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 48.0, vertical: 12.0),
                        child: Text(
                          'Pending Tasks',
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
                                builder: (context) =>
                                    FinancePendingTicketListPage()));
                      },
                    ),
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
