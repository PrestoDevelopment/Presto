import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:presto_mobile/core/models/user_model.dart';
import 'package:presto_mobile/core/services/dialog_service.dart';
import 'package:presto_mobile/core/viewModels/otp_view_model.dart';
import 'package:presto_mobile/ui/resources/Colors.dart' as color;
import 'package:presto_mobile/ui/widgets/busybutton.dart';
import 'package:stacked/stacked.dart';

import '../../locator.dart';

class OtpVerificationView extends StatefulWidget {
  final UserModel user;

  OtpVerificationView({this.user});

  @override
  _OtpVerificationViewState createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView> {
  final DialogService _dialogService = locator<DialogService>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OtpViewModel>.reactive(
      viewModelBuilder: () => OtpViewModel(),
      onModelReady: (model) => model.onReady(widget.user),
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextField(
                  text: 'Verification Code',
                  fontSize: 40.0,
                  textColor: color.color1,
                  containerHeight: MediaQuery.of(context).size.height / 7,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 7,
                ),
                TextField(
                  text: 'Please Enter the OTP sent',
                  fontSize: 20.0,
                  textColor: Colors.black,
                ),
                TextField(
                  text: 'on your registered phone number',
                  fontSize: 20.0,
                  textColor: Colors.black,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 15,
                    left: MediaQuery.of(context).size.width / 15,
                    right: MediaQuery.of(context).size.width / 15,
                    bottom: MediaQuery.of(context).size.height/15,
                  ),
                  child: OTPTextField(
                    length: 6,
                    width: MediaQuery.of(context).size.width,
                    fieldWidth: 40,
                    style: TextStyle(fontSize: 17),
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldStyle: FieldStyle.underline,
                    onCompleted: (pin) {
                      ///Send OTP to complete the manual confirmation
                      model.setOtp(pin);
                      print("Completed: " + pin);
                    },
                  ),
                ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height / 18,
                // ),
                // TextField(
                //   textColor: Colors.black,
                //   text: 'Resend the OTP after',
                //   fontSize: 20.0,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     Center(
                //       child: Countdown(
                //         duration: Duration(seconds: 90),
                //         onFinish: () {
                //           model.setFlag(false);
                //           //resendOtp
                //           print('finished!');
                //         },
                //         builder: (BuildContext ctx, Duration remaining) {
                //           return Text(
                //             '${remaining.inMinutes}:${remaining.inSeconds} seconds',
                //             style: TextStyle(fontSize: 20.0),
                //           );
                //         },
                //       ),
                //     ),
                //     SizedBox(
                //       width: MediaQuery.of(context).size.width / 50,
                //     ),
                //     Visibility(
                //       visible: model.flag,
                //       child: GestureDetector(
                //         onTap: () {
                //           ///Show confirmation dialog box to resend the OTP
                //         },
                //         child: TextField(
                //           containerWidth: MediaQuery.of(context).size.width / 5,
                //           text: 'Resend Now!',
                //           fontSize: 20.0,
                //           textColor: Colors.blue,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                ),
                BusyButton(
                  title: "Verify",
                  busy: model.isBusy,
                  onPressed: () async {
                    //Manual otp send
                    var result;
                    if (model.otp != null) result = await model.signIn();
                    if (result is bool) {
                      if (result) {
                        // Navigator.of(context).pushReplacement(
                        //   MaterialPageRoute(
                        //     builder: (context) => InfoSlider(),
                        //     settings: RouteSettings(
                        //       name: InfoSliderRoute,
                        //     ),
                        //   ),
                        // );
                      } else {
                        _dialogService.showDialog(
                          title: "Error",
                          description: "there's some sort of error",
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextField extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final double containerHeight;
  final double containerWidth;

  TextField(
      {this.text,
      this.fontSize,
      this.textColor,
      this.containerHeight,
      this.containerWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerWidth == null
          ? MediaQuery.of(context).size.width
          : containerWidth,
      height: containerHeight,
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: fontSize),
        ),
      ),
    );
  }
}
