import 'package:flutter/material.dart';
import 'package:presto_mobile/core/viewmodels/main_model.dart';
import 'package:presto_mobile/ui/resources/Colors.dart' as color;
import 'package:progress_indicators/progress_indicators.dart';
import 'package:stacked/stacked.dart';

class MainPageView extends StatefulWidget {
  @override
  _MainPageViewState createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  // final AuthenticationService _authenticationService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainPageModel>.reactive(
      viewModelBuilder: () => MainPageModel(),
      onModelReady: (model) => model.onReady(),
      builder: (context, model, child) => model.busy
          ? Center(
              child: Container(
                child: FadingText(
                  'Loading Main Page...',
                ),
              ),
            )
          : Scaffold(
              body: SafeArea(
                child: IndexedStack(
                  index: model.selectedIndex,
                  children: model.pageOptions,
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline),
                    label: 'Profile',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.monetization_on),
                    label: 'Recent',
                  ),
                ],
                backgroundColor: Colors.white,
                currentIndex: model.selectedIndex,
                unselectedItemColor: Colors.black,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: color.color1,
                onTap: (value) => model.onTappedBar(value),
              ),
            ),
    );
  }
}
