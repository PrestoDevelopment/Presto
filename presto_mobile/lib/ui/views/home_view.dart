import 'package:flutter/material.dart';
import 'package:presto_mobile/core/viewmodels/home_model.dart';
import 'package:presto_mobile/ui/widgets/busybutton.dart';
import 'package:provider_architecture/provider_architecture.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HomeModel>.withConsumer(
        viewModelBuilder: () => HomeModel(),
        builder: (context, model, child) => Scaffold(
              body: Center(
                child: Column(
                  children: [
                    Text("Homepage"),
                    BusyButton(
                      title: "SignOut",
                      onPressed: () async {
                        model.signOut();
                      },
                    ),
                  ],
                ),
              ),
            ));
  }
}
