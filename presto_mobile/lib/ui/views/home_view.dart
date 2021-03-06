import 'package:flutter/material.dart';
import 'package:presto_mobile/core/viewmodels/home_model.dart';
import 'package:presto_mobile/ui/resources/Colors.dart' as color;
import 'package:presto_mobile/ui/widgets/amountButton.dart';
import 'package:presto_mobile/ui/widgets/busybutton.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return ViewModelBuilder<HomeModel>.reactive(
      viewModelBuilder: () => HomeModel(),
      onModelReady: (model) => model.onReady(),
      builder: (context, model, child) => model.borrowingLimits == null
          ? Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Container(
                  child: FadingText(
                    'Loading ...',
                  ),
                ),
              ),
            )
          : Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Container(
                    //   child: FadingText(
                    //     model.user?.name ?? "Error",
                    //   ),
                    // ),
                    Container(
                      width: width,
                      height: height / 3.7,
                      decoration: BoxDecoration(
                          color: color.color1,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(40),
                              bottomLeft: Radius.circular(40))),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: height / 20,
                          ),
                          Text(
                            'Amount Demanded',
                            style:
                                TextStyle(color: Colors.white, fontSize: 30.0),
                          ),
                          SizedBox(
                            height: height / 22,
                          ),
                          Text(
                            "₹${model.amount?.toInt().toString() ?? 'Error'}",
                            style:
                                TextStyle(color: Colors.white, fontSize: 50.0),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 25,
                    ),
                    Text(
                      'Present Amount',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    SizedBox(height: height / 40),
                    Padding(
                      padding: EdgeInsets.only(
                        right: width / 8.7,
                        left: width / 8.7,
                      ),
                      child: Row(
                        children: <Widget>[
                          AmountButton(
                            text: "+50",
                            onTap: () => model.increaseAmount(50.0),
                          ),
                          AmountButton(
                            text: "+100",
                            onTap: () => model.increaseAmount(100.0),
                          ),
                          AmountButton(
                            text: "+150",
                            onTap: () => model.increaseAmount(150.0),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: width / 8.7, left: width / 8.7),
                      child: Row(
                        children: <Widget>[
                          AmountButton(
                            text: "-50",
                            onTap: () => model.decreaseAmount(50.0),
                          ),
                          AmountButton(
                            text: "-100",
                            onTap: () => model.decreaseAmount(100.0),
                          ),
                          AmountButton(
                            text: "-150",
                            onTap: () => model.decreaseAmount(150.0),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height / 15,
                    ),
                    Text(
                      'Set Amount Manually',
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: height / 30,
                        right: width / 80.7,
                        left: width / 80.7,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                                activeTrackColor: color.color3,
                                inactiveTrackColor: Color(0xFF8D8E98),
                                overlayColor: Color(0x29EB1555),
                                thumbColor: color.color1,
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 15.0),
                                overlayShape: RoundSliderOverlayShape(
                                    overlayRadius: 30.0)),
                            child: Slider(
                              value: model.amount ?? 0.0,
                              max: model.borrowingLimits != null
                                  ? model.borrowingLimits["borrowUpperLimit"]
                                  : 0.0,
                              min: model.borrowingLimits != null
                                  ? model.borrowingLimits["borrowLowerLimit"]
                                  : 0.0,
                              onChanged: (double newValue) {
                                print("Changing the value");
                                model.setAmount(newValue);
                              },
                            ),
                          ),
                          Text(
                            "₹${model.amount?.ceil()?.toString() ?? 'error'}",
                            style:
                                TextStyle(color: Colors.black, fontSize: 30.0),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height / 20,
                    ),
                    BusyButton(
                      title: "Get Paid!",
                      busy: model.isBusy || model.borrowingLimits == null,
                      onPressed: () async => model.goToPaymentPage(),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
