import 'package:flutter/material.dart';
import 'package:presto_mobile/core/viewmodels/profile_model.dart';
import 'package:presto_mobile/ui/resources/Colors.dart' as color;
import 'package:presto_mobile/ui/widgets/SideNavDrawer.dart';
import 'package:presto_mobile/ui/widgets/listToken.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:stacked/stacked.dart';
import 'package:share/share.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return ViewModelBuilder<ProfileModel>.reactive(
        viewModelBuilder: () => ProfileModel(),
        onModelReady: (model) => model.onReady(),
        builder: (context, model, child) {
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
                    key: scaffoldKey,
                    backgroundColor: Colors.white,
                    drawer: Container(
                      color: Colors.white,
                      child: SideNavDrawer(
                        verificationColor: model.user.emailVerified ? Colors.green : Colors.red,
                        logoutTap: (){
                          //Sign Out
                          model.signOut();
                          },
                        shareTap: (){
                          final RenderBox box = context.findRenderObject();
                          Share.share(
                            "Hey! Checkout our new Community Building app where you can get small loans as fast as your husbands orgy ;)",
                            subject: "Download Now",
                            sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size
                          );
                        },
                      ),
                    ),
                    body: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          ConstrainedBox(
                            constraints: BoxConstraints(minHeight: height / 4.25),
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
                                crossAxisAlignment:CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 12.0, top: 5.0),
                                        child: IconButton(
                                          color: Colors.white,
                                            icon: Icon(Icons.menu),
                                            onPressed: () => scaffoldKey.currentState.openDrawer(),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5.0, left: 14.0, bottom: 5.0),
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
                                          top: 5.0,
                                          left: 14.0,
                                        ),
                                        child: Text(
                                          model.user != null
                                              ? '${model.user.email}'
                                              : 'loading',
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white),
                                        ),
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
                            height: 50.0,
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
                                trailName:
                                    '₹ ${model.user?.totalBorrowed ?? '0'}',
                              ),
                              ListToken(
                                name: 'Total Amount Lended',
                                icon: Icons.monetization_on,
                                trailName: '₹ ${model.user?.totalLent ?? '0'}',
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
                                trailName: '${model.creditWorthyScore ?? '0'}',
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
                );
        });
  }
}
