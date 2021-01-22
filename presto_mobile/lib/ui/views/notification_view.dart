import 'package:flutter/material.dart';
import 'package:presto_mobile/core/viewModels/notification_model.dart';
import 'package:presto_mobile/ui/resources/Colors.dart' as color;
import 'package:stacked/stacked.dart';

class NotificationView extends StatefulWidget {
  final Notification notification;

  NotificationView({this.notification});

  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => NotificationModel(),
      builder: (context, widget, child) {
        return SafeArea(
          child: Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: height / 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      backgroundColor: color.color1,
                      radius: 60.0,
                      child: Text('Local Icon',
                          style:
                              TextStyle(color: Colors.white, fontSize: 25.0)),
                    ),
                    Column(
                      children: [
                        Text(
                          'Creditworthy Score: ${widget.notification.score}',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        Text(
                          'Mode of payment:',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        Container(
                            height: height / 5,
                            width: width / 4,
                            child: Image.asset('assets/images/paytm.png')),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: height / 15,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Amount Requested : ${widget.notification.amount}',
                    style:
                        TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: width / 2,
                  child: Divider(
                    color: color.color1,
                    thickness: 5.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 20.0),
                  child: Container(
                    width: width / 2,
                    child: Text(
                      'A fellow Bitsian is calling...',
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height / 4,
                ),
                Row(
                  children: [
                    GestureDetector(
                      child: Container(
                        width: width / 2,
                        height: height / 15,
                        color: Colors.green,
                        child: Center(
                          child: Text(
                            'Yes',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        width: width / 2,
                        height: height / 15,
                        color: Colors.red,
                        child: Center(
                          child: Text(
                            'No',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
