import 'package:flutter/material.dart';
import 'package:presto_mobile/core/viewmodels/login_model.dart';
import 'package:presto_mobile/ui/resources/Colors.dart' as color;
import 'package:presto_mobile/ui/widgets/busybutton.dart';
import 'package:presto_mobile/ui/widgets/datainput.dart';
import 'package:presto_mobile/ui/widgets/passinput.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginModel>.reactive(
      viewModelBuilder: () => LoginModel(),
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
                            "Welcome Back",
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
                      top: MediaQuery.of(context).size.height / 3.7,
                      right: 20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Login to continue",
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
                        controller: emailController,
                        hintText: "abc@xyz.com",
                        prefixIcon: Icon(
                          Icons.email,
                          color: color.color1,
                        ),
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
                        hintText: "Password",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          //Add Forgot Password Page
                          // Navigator.pushNamed((context), ForgetPassword.id);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              "Forget Password?",
                              style: TextStyle(
                                fontSize: 15,
                                color: color.neon,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 6.6,
                      ),
                      BusyButton(
                        title: "Log In",
                        busy: model.isBusy,
                        onPressed: () {
                          print("initiating login Process");
                          model.login(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () async {
                          await model.navigateToSignUp();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "New to Presto?",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              " Sign Up Now",
                              style: TextStyle(
                                fontSize: 18,
                                color: color.neon,
                              ),
                            )
                          ],
                        ),
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
