import 'package:flutter/material.dart';
import 'package:presto_mobile/core/viewmodels/main_model.dart';
import 'package:presto_mobile/ui/resources/Colors.dart' as color;
import 'package:presto_mobile/ui/views/failure_view.dart';
import 'package:presto_mobile/ui/views/home_view.dart';
import 'package:presto_mobile/ui/views/infoSlider.dart';
import 'package:presto_mobile/ui/views/list_notification_view.dart';
import 'package:presto_mobile/ui/views/profile_view.dart';
import 'package:presto_mobile/ui/views/transactions_view.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:stacked/stacked.dart';

class MainPageView extends StatefulWidget {
  @override
  _MainPageViewState createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {
  // final AuthenticationService _authenticationService = AuthenticationService();

  final Map<int, Widget> _viewCache = Map<int, Widget>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainPageModel>.reactive(
        viewModelBuilder: () => MainPageModel(),
        builder: (context, model, child) {
          return model.isBusy || !model.hasData
              ? Center(
                  child: Container(
                    child: FadingText(
                      'Loading ...',
                    ),
                  ),
                )
              : Scaffold(
                  body: getViewForIndex(
                    model.selectedIndex,
                    model.data,
                  ),
                  bottomNavigationBar: BottomNavigationBar(
                    items: [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.person_outline),
                          label: 'Profile',
                          activeIcon: Icon(
                            Icons.person_outline,
                            size: 40.0,
                          )),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home),
                          label: 'Home',
                          activeIcon: Icon(
                            Icons.home,
                            size: 40.0,
                          )),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.monetization_on),
                          label: 'Transactions',
                          activeIcon: Icon(
                            Icons.monetization_on,
                            size: 40.0,
                          )),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.notifications),
                          label: 'Notifications',
                          activeIcon: Icon(
                            Icons.notifications,
                            size: 40.0,
                          ))
                    ],
                    backgroundColor: Colors.white,
                    currentIndex: model.selectedIndex,
                    unselectedItemColor: Colors.black,
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: color.color1,
                    onTap: (value) => model.onTappedBar(value),
                  ),
                );
        });
  }

  Widget getViewForIndex(int index, dynamic snapshots) {
    if (!_viewCache.containsKey(index)) {
      switch (index) {
        case 0:
          _viewCache[index] = ProfileView();
          break;
        case 1:
          _viewCache[index] = HomeView();
          break;
        case 2:
          _viewCache[index] = InfoSlider();
          //_viewCache[index] = TransactionsView();
          break;
        case 3:
          _viewCache[index] = ListNotificationView(
            snapshots: snapshots,
          );
      }
    }

    return _viewCache[index];
  }
}
