import 'package:flutter/material.dart';
import 'package:presto_mobile/core/viewmodels/profile_model.dart';
import 'package:presto_mobile/ui/widgets/listToken.dart';
import 'package:stacked/stacked.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:presto_mobile/ui/resources/Colors.dart' as color;

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return ViewModelBuilder<ProfileModel>.reactive(
      viewModelBuilder: () => ProfileModel(),
      onModelReady: (model) => model.onReady(),
      builder: (context, model, child) => model.busy
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
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      ConstrainedBox(
                        constraints: BoxConstraints(minHeight: height / 4),
                        child: Container(
                          //height: MediaQuery.of(context).size.height/4,
                          width: width,
                          decoration: BoxDecoration(
                            color: color.color1,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 14.0, left: 14.0, bottom: 5.0),
                                    child: Container(
                                      //height: MediaQuery.of(context).size.height/17,
                                      width: width / 1.6,
                                      child: Text(
                                        model.user != null
                                            ? '${model.user.name}'
                                            : 'loading',
                                        style: TextStyle(
                                            fontSize: 30.0,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 14.0,
                                    ),
                                    child: Text(
                                      model.user != null
                                          ? '${model.user.email}'
                                          : 'loading',
                                      style: TextStyle(
                                          fontSize: 15.0, color: Colors.white),
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Icon(
                                          Icons.settings,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Icon(
                                          Icons.developer_board,
                                          color: Colors.white,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          //Sign Out
                                          model.signOut();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Icon(
                                            Icons.power_settings_new,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          //In App Notification Page

                                          // Navigator.of(context)
                                          //     .push(MaterialPageRoute(
                                          //   builder: (context) =>
                                          //       InAppNotificationPage(),
                                          //   settings: RouteSettings(
                                          //       name: InAppNotificationPage.id),
                                          // ));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Icon(
                                            Icons.notifications,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 16.0,
                                    bottom: 16.0,
                                    left: 10.0,
                                    right: 10.0),
                                child: CircleAvatar(
                                  radius: 60.0,
                                  backgroundColor: Colors.white,
                                  child: Image.asset(
                                      'assets/images/PrestoLogo.png'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 70.0,
                      ),
                      Column(
                        children: <Widget>[
                          ListToken(
                            name: 'Contact Number',
                            icon: Icons.phone,
                            trailName: model.user != null
                                ? '${model.user.contact}'
                                : 'error',
                          ),
                          ListToken(
                            name: 'Total Amount Borrowed',
                            icon: Icons.attach_money,
                            trailName: '₹ 50.0',
                          ),
                          ListToken(
                            name: 'Total Amount Lended',
                            icon: Icons.monetization_on,
                            trailName: '₹ 50.0',
                          ),
                          ListToken(
                            name: 'Most Used Mode',
                            icon: Icons.chrome_reader_mode,
                            trailName: 'Paytm',
                          ),
                          ListToken(
                            name: 'Community Code',
                            icon: Icons.info,
                            trailName: model.user != null
                                ? '${model.user.referralCode}'
                                : 'error',
                          ),
                          ListToken(
                            name: 'Creditworthy score',
                            icon: Icons.credit_card_rounded,
                            trailName: '60.0',
                          ),
                          SizedBox(
                            height: height / 18,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
