import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:presto_mobile/core/models/user_model.dart';
import 'package:presto_mobile/core/services/firestore_service.dart';
import 'package:presto_mobile/core/services/navigation_service.dart';
// import 'package:presto_mobile/core/viewmodels/otp_model.dart';
import 'package:presto_mobile/ui/resources/Colors.dart' as color;

class OtpVerificationView extends StatefulWidget {
  UserModel user;

  OtpVerificationView({this.user});

  @override
  _OtpVerificationViewState createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<OtpVerificationView> {
  final FireStoreService _fireStoreService = FireStoreService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  NavigationService _navigationService = NavigationService();
  String verificationID; // Contains the verification ID
  AuthCredential userCredential;
  String status;

  Future verifyPhone() async {
    //Defining few methods first
    final PhoneCodeSent phoneCodeSent =
        (String verID, [int forceResendingToken]) {
      //this method is called when otp is sent to user
      setState(() {
        print("--------");
        print("Phone Code Sent");
        print("--------");
        status = "Phone Code Sent";
        verificationID =
            verID; //verification ID is set to actual ID that is provided when Phone Code is Sent
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verID) {
      //this method is called when auto retrieval timeout is over
      setState(() {
        verificationID =
            verID; //verification ID is set to actual ID that is provided when Phone Code is Sent
        status = "Phone code auto retrieval time out";
      });
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException e) {
      setState(() {
        print(e.message);
        status = "Verification fail";
      });
    };

    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential credential) {
      setState(() {
        userCredential = credential;
        print(credential.providerId.toLowerCase());
        status = "verification cocmpleted";
      });
    };

    //Method to start verification process
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91' + widget.user.contact,
      //phone-number is supplied
      timeout: Duration(seconds: 10),
      //timeout duration
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: phoneCodeSent,
      codeAutoRetrievalTimeout: autoRetrievalTimeout,
    );
  }

  Future signIn(String verID, AuthCredential credential, String otp) async {
    if (credential == null) {
      //In-case Auto retrieve doesn't work
      print("MAnual");
      try {
        var userCred =
            PhoneAuthProvider.credential(verificationId: verID, smsCode: otp);
        if (userCred is AuthCredential) {
          print("Phone Updated");
        }
        setState(() {
          widget.user.contactVerified = true;
          status = "manual signin";
        });
        var result = await _fireStoreService.userDocUpdate(widget.user);
        if (result is bool) {
          if (result)
            _navigationService.pop();
          else
            print("Error 2");
        } else
          print("Error 1");
      } catch (e) {
        print(e.toString());
      }
    } else {
      try {
        //In-case Auto retrieve works
        setState(() {
          widget.user.contactVerified = true;
        });
        var result = await _fireStoreService.userDocUpdate(widget.user);
        if (result is bool) {
          if (result)
            _navigationService.pop();
          else
            print("Error 2");
        } else
          print("Error 1");
      } catch (e) {
        print(e.toString());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    verifyPhone();
  }

  @override
  Widget build(BuildContext context) {
    bool flag = false;

    return Scaffold(
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
              ),
              child: OTPTextField(
                length: 6,
                width: MediaQuery.of(context).size.width,
                fieldWidth: 40,
                style: TextStyle(fontSize: 17),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.underline,
                onCompleted: (pin) {
                  print("Completed: " + pin);
                  if (pin.length < 6) {
                    print("No OTP");
                  } else {
                    signIn(verificationID, userCredential, pin);
                  }
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 18,
            ),
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
            //           //
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
            //       visible: flag,
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
            Text(status),
          ],
        ),
      ),
    );

    // return ViewModelBuilder<OtpModel>.reactive(
    //   viewModelBuilder: () => OtpModel(),
    //   onModelReady: (model) => model.onReady(widget.user),
    //   builder: (context, model, child) => SafeArea(
    //     child: Scaffold(
    //       body: SingleChildScrollView(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: <Widget>[
    //             TextField(
    //               text: 'Verification Code',
    //               fontSize: 40.0,
    //               textColor: color.color1,
    //               containerHeight: MediaQuery.of(context).size.height / 7,
    //             ),
    //             SizedBox(
    //               height: MediaQuery.of(context).size.height / 7,
    //             ),
    //             TextField(
    //               text: 'Please Enter the OTP sent',
    //               fontSize: 20.0,
    //               textColor: Colors.black,
    //             ),
    //             TextField(
    //               text: 'on your registered phone number',
    //               fontSize: 20.0,
    //               textColor: Colors.black,
    //             ),
    //             Padding(
    //               padding: EdgeInsets.only(
    //                 top: MediaQuery.of(context).size.height / 15,
    //                 left: MediaQuery.of(context).size.width / 15,
    //                 right: MediaQuery.of(context).size.width / 15,
    //               ),
    //               child: OTPTextField(
    //                 length: 6,
    //                 width: MediaQuery.of(context).size.width,
    //                 fieldWidth: 40,
    //                 style: TextStyle(fontSize: 17),
    //                 textFieldAlignment: MainAxisAlignment.spaceAround,
    //                 fieldStyle: FieldStyle.underline,
    //                 onCompleted: (pin) {
    //                   ///Send OTP to complete the manual confirmation
    //                   print("Completed: " + pin);
    //                 },
    //               ),
    //             ),
    //             SizedBox(
    //               height: MediaQuery.of(context).size.height / 18,
    //             ),
    //             TextField(
    //               textColor: Colors.black,
    //               text: 'Resend the OTP after',
    //               fontSize: 20.0,
    //             ),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: <Widget>[
    //                 Center(
    //                   child: Countdown(
    //                     duration: Duration(seconds: 90),
    //                     onFinish: () {
    //                       model.setFlag(false);
    //                       //resendOtp
    //                       print('finished!');
    //                     },
    //                     builder: (BuildContext ctx, Duration remaining) {
    //                       return Text(
    //                         '${remaining.inMinutes}:${remaining.inSeconds} seconds',
    //                         style: TextStyle(fontSize: 20.0),
    //                       );
    //                     },
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   width: MediaQuery.of(context).size.width / 50,
    //                 ),
    //                 Visibility(
    //                   visible: model.flag,
    //                   child: GestureDetector(
    //                     onTap: () {
    //                       ///Show confirmation dialog box to resend the OTP
    //                     },
    //                     child: TextField(
    //                       containerWidth: MediaQuery.of(context).size.width / 5,
    //                       text: 'Resend Now!',
    //                       fontSize: 20.0,
    //                       textColor: Colors.blue,
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             SizedBox(
    //               height: MediaQuery.of(context).size.height / 4,
    //             ),
    //
    //             ///Busy Button to verify the OTP
    //             BusyButton(title: "Verify", onPressed: () {})
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
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
