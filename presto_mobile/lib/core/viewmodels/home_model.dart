import 'package:presto_mobile/core/services/dialog_service.dart';
import 'package:presto_mobile/core/services/firestore_service.dart';
import 'package:presto_mobile/locator.dart';
import 'package:stacked/stacked.dart';

class HomeModel extends BaseViewModel {
  // final AuthenticationService _authenticationService = AuthenticationService();
  final DialogService _dialogService = locator<DialogService>();

  // final NavigationService _navigationService = locator<NavigationService>();
  final FireStoreService _fireStoreService = FireStoreService();

  // final SharedPreferencesService _preferencesService =
  //     SharedPreferencesService();
  double _amount = 100.0;

  double get amount => _amount;
  Map<String, dynamic> _borrowingLimits;

  Map<String, dynamic> get borrowingLimits => _borrowingLimits;

  // bool get hasUserData => dataReady(_UserDataStreamKey);
  // UserModel get user => dataMap[_UserDataStreamKey];

  void onReady() async {
    print("Getting limits in Home view !!!!!!!!!!!!!");
    // var temp =
    //     await _fireStoreService.getUser(_authenticationService.retrieveCode());
    // if (temp is UserModel) {
    //   _user = temp;
    //   print("Got user in home View!!");
    //   notifyListeners();
    // }
    setBusy(true);
    await _fireStoreService.getBorrowingLimit().then((value) {
      _borrowingLimits = value;
      _amount = _borrowingLimits["borrowLowerLimit"];
      setBusy(false);
    });
    // listenToDatabase();
  }

  // void listenToDatabase() {
  //   setBusy(true);
  //   // _fireStoreService
  //   //     .listenToUserDocumentRealTime(_authenticationService.retrieveCode())
  //   //     ?.listen((updateUser) {
  //   //   if (updateUser != null) {
  //   //     print("Got user Update");
  //   //     _user = updateUser;
  //   //     notifyListeners();
  //   //   }
  //   // });
  //   _fireStoreService.listenToUserLimitsRealTime()?.listen((updateLimit) {
  //     if (updateLimit != null) {
  //       print("Got limits Update");
  //       _borrowingLimits = {
  //         "borrowUpperLimit": updateLimit["borrowUpperLimit"].toDouble(),
  //         "borrowLowerLimit": updateLimit["borrowLowerLimit"].toDouble(),
  //       };
  //       _amount = _borrowingLimits["borrowLowerLimit"];
  //       notifyListeners();
  //     }
  //   });
  //   setBusy(false);
  // }

  void increaseAmount(double value) {
    if (_borrowingLimits.isNotEmpty) {
      setBusy(true);
      if (_amount + value <= _borrowingLimits["borrowUpperLimit"]) {
        _amount = _amount + value;
        notifyListeners();
        setBusy(false);
      } else {
        setBusy(false);
        _dialogService.showDialog(
          title: 'To Much Greedy',
          description: 'You have exceeded maximum limit to borrow',
        );
      }
    }
  }

  void decreaseAmount(double value) {
    setBusy(true);
    if (_borrowingLimits.isNotEmpty) {
      if (_amount - value >= _borrowingLimits["borrowLowerLimit"]) {
        _amount = _amount - value;
        notifyListeners();
        setBusy(false);
      } else {
        setBusy(false);
        _dialogService.showDialog(
          title: 'Have Some Dignity',
          description: 'You have exceeded minimum limit to borrow',
        );
      }
    }
  }

  void setAmount(double value) {
    setBusy(true);
    _amount = value;
    notifyListeners();
    setBusy(false);
  }

// @override
// Map<String, StreamData> get streamsMap => {
//       _UserDataStreamKey: StreamData<UserModel>(
//           _fireStoreService.listenToUserDocumentRealTime(
//               _authenticationService.retrieveCode())),
//       _UserLimitStreamKey:
//           StreamData<Map>(_fireStoreService.listenToUserLimitsRealTime()),
//     };
// @override
// Stream get stream => _fireStoreService.listenToUserLimitsRealTime();
}
