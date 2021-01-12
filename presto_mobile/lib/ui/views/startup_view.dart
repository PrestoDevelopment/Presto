import 'package:flutter/material.dart';
import 'package:presto_mobile/core/viewmodels/startup_model.dart';
import 'package:stacked/stacked.dart';

class StartUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Show the splash Screen
    return ViewModelBuilder<StartUpModel>.reactive(
      viewModelBuilder: () => StartUpModel(),
      onModelReady: (model) => model.handleStartUpLogic(),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
