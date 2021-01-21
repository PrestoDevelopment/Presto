import 'package:flutter/material.dart';
import 'package:presto_mobile/core/viewmodels/signup_model.dart';
import 'package:presto_mobile/ui/resources/Colors.dart' as color;
import 'package:presto_mobile/ui/widgets/busybutton.dart';
import 'package:presto_mobile/ui/widgets/datainput.dart';
import 'package:presto_mobile/ui/widgets/passinput.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController parentReferralCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpModel>.reactive(
      viewModelBuilder: () => SignUpModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            "Create Account",
                            style: TextStyle(
                              fontSize: 45,
                              color: color.color1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 5,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 20,
                      top: MediaQuery.of(context).size.height / 7,
                      right: 20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Sign up to get Started",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 35,
                      ),
                      DataInput(
                        controller: nameController,
                        prefixIcon: Icon(
                          Icons.person_outline,
                          color: color.color1,
                        ),
                        hintText: "Your Name",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DataInput(
                        controller: emailController,
                        prefixIcon: Icon(
                          Icons.email,
                          color: color.color1,
                        ),
                        hintText: "abc@xyz.com",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DataInput(
                        controller: contactController,
                        prefixIcon: Icon(
                          Icons.contact_phone,
                          color: color.color1,
                        ),
                        hintText: "10 digit mobile number",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      PassInput(
                        controller: passwordController,
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: color.color1,
                        ),
                        hintText: "Must be atleast 6 characters long",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DataInput(
                        controller: parentReferralCode,
                        prefixIcon: Icon(
                          Icons.info,
                          color: color.color1,
                        ),
                        hintText: "Referral Code",
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      BusyButton(
                        title: "Sign Up",
                        busy: model.isBusy,
                        onPressed: () {
                          print("initiating signUP");
                          model.signUp(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                            nameController.text.trim(),
                            contactController.text.trim(),
                            parentReferralCode.text.trim(),
                          );
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () async {
                          await model.navigateToLogin();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Already a Presto Member?",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              " Log In Now",
                              style: TextStyle(
                                fontSize: 18,
                                color: color.neon,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
