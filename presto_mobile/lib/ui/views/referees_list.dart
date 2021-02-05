import 'package:flutter/material.dart';
import 'package:presto_mobile/core/viewModels/referees_list_model.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:stacked/stacked.dart';
class RefereesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return ViewModelBuilder<RefereesListModel>.reactive(
      viewModelBuilder: () => RefereesListModel(),
      builder: (context,model,child) {
        int lengthOfList;
        if(model.user.referredTo == null){
          lengthOfList = 0;
        }else{
          lengthOfList = model.user.referredTo.length;
        }
        model.getRefereesDetails();
        return !model.hasUserData ? Center(
          child: Container(
            child: FadingText(
              'Loading list...',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
        ) : SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: height/20.0,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Referees List",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30.0
                        ),
                      ),
                    ),
                    ListView.builder(
                      itemCount: lengthOfList,
                        itemBuilder: (BuildContext context, int index){
                          if(lengthOfList==0){
                            return Center(
                              child: Text(
                                "You haven't referred us to anyone",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black
                                ),
                              ),
                            );
                          }else{
                            return Card(
                              elevation: 5.0,
                              child: Padding(
                                padding: EdgeInsets.all(6.0),
                                child: ExpansionTile(
                                  title: Text(
                                      model.refereeListManager[index].getName(),
                                    style: TextStyle(
                                      fontSize: 15.0
                                    ),
                                  ),
                                  children: [
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left:20.0),
                                          child: Text(
                                            "Email"
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(right: 20.0),
                                          child: Text(
                                            model.refereeListManager[index].getEmail()
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left:20.0),
                                          child: Text(
                                              "Contact"
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(right: 20.0),
                                          child: Text(
                                              model.refereeListManager[index].getContact()
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left:20.0),
                                          child: Text(
                                              "Referral Code"
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(right: 20.0),
                                          child: Text(
                                              model.refereeListManager[index].getReferralCode()
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                    )
                  ],
                ),
              ),
            )
        );
      },
    );
  }
}
