import 'package:flutter/material.dart';
import 'package:presto_mobile/core/viewModels/list_notification_model.dart';
import 'package:presto_mobile/ui/widgets/notificationListCard.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:stacked/stacked.dart';

import '../resources/Colors.dart';
class ListNotificationView extends StatefulWidget {
  @override
  _ListNotificationViewState createState() => _ListNotificationViewState();
}

class _ListNotificationViewState extends State<ListNotificationView> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return ViewModelBuilder<ListNotificationModel>.reactive(
        viewModelBuilder: () => ListNotificationModel(),
        builder: (context,model,child){
          return !model.hasUserData
              ? Center(
                  child: Container(
                    child: FadingText(
                      'Loading profile...',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
              )
              : SafeArea(
                  child: Scaffold(
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height/20,
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            'All Notifications',
                            style: TextStyle(
                              color: color1,
                              fontSize: 30.0
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height/30,
                        ),
                        notificationListCard(),
                      ],
                    ),
                  )
              );
          }
    );
  }
}
