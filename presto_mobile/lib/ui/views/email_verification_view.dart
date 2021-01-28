import 'package:flutter/material.dart';
import 'package:presto_mobile/core/viewModels/email_verification_model.dart';
import 'package:presto_mobile/ui/resources/Colors.dart';
import 'package:stacked/stacked.dart';
class EmailVerificationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => EmailVerificationModel(),
      builder: (context,model,child) => SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              SizedBox(
                height: height/20,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Email Verification",
                  style: TextStyle(
                    fontSize: 45.0,
                    color: color1
                  ),
                ),
              ),
              SizedBox(
                height: height/10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'A verification link has been sent to your email acount',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17.0
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'PLease click on the link that has been sent to your email account to verify your email and continue the registration process',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.0
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
