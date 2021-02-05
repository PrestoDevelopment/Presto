import 'package:flutter/material.dart';
import 'package:presto_mobile/core/models/user_model.dart';
import 'package:presto_mobile/core/viewModels/referees_list_model.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:stacked/stacked.dart';

class RefereesList extends StatelessWidget {
  final UserModel user;

  RefereesList({this.user});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return ViewModelBuilder<RefereesListModel>.reactive(
      viewModelBuilder: () => RefereesListModel(),
      onModelReady: (model) => model.getRefereesDetails(user),
      builder: (context, model, child) {
        return model.isBusy
            ? Scaffold(
                body: Center(
                  child: Container(
                    child: FadingText(
                      'Loading list...',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              )
            : SafeArea(
                child: Scaffold(
                  backgroundColor: Colors.white,
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height:
                              model.refereeListManager.refereeList.length == 0
                                  ? height / 3.0
                                  : height / 20.0,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Referees List",
                            style:
                                TextStyle(color: Colors.black, fontSize: 30.0),
                          ),
                        ),
                        model.refereeListManager.refereeList.length == 0
                            ? Center(
                                child: Text(
                                  "You haven't referred us to anyone!! \nRefer Someone and view them here.",
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.black),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    model.refereeListManager.refereeList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    elevation: 5.0,
                                    child: Padding(
                                      padding: EdgeInsets.all(6.0),
                                      child: ExpansionTile(
                                        title: Text(
                                          model.refereeListManager
                                              .refereeList[index].name,
                                          style: TextStyle(fontSize: 15.0),
                                        ),
                                        children: [
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 20.0),
                                                child: Text("Email"),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: 20.0),
                                                child: Text(
                                                  model.refereeListManager
                                                      .refereeList[index].email,
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 20.0),
                                                child: Text("Contact"),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: 20.0),
                                                child: Text(
                                                  model
                                                      .refereeListManager
                                                      .refereeList[index]
                                                      .contact,
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 20.0),
                                                child: Text("Referral Code"),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: 20.0),
                                                child: Text(
                                                  model
                                                      .refereeListManager
                                                      .refereeList[index]
                                                      .referralCode,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
