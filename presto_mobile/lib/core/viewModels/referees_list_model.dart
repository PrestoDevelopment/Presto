import 'package:presto_mobile/core/models/user_model.dart';
import 'package:presto_mobile/core/services/authentication_service.dart';
import 'package:presto_mobile/core/services/dialog_service.dart';
import 'package:presto_mobile/core/services/firestore_service.dart';
import 'package:presto_mobile/core/services/navigation_service.dart';
import 'package:presto_mobile/managers/referee_list_manager.dart';
import 'package:stacked/stacked.dart';
import 'package:presto_mobile/locator.dart';
class RefereesListModel extends StreamViewModel{

  final AuthenticationService _authenticationService = AuthenticationService();
  final NavigationService _navigationService = locator<NavigationService>();
  final FireStoreService _fireStoreService = FireStoreService();
  final DialogService _dialogService = locator<DialogService>();
  List<RefereeListManager> refereeListManager;

  bool get hasUserData => dataReady;

  UserModel get user => data;

  void getRefereesDetails() async {
    if(user.referredTo != null){
      for(int i = 0 ; i < user.referredTo.length ; i++){
          UserModel userModel = await _fireStoreService.getUser(user.referredTo[i]);
          refereeListManager[i].setData(userModel.name,userModel.email,userModel.contact,userModel.referralCode);
      }
    }
  }

  @override
  Stream get stream => _fireStoreService
      .listenToUserDocumentRealTime(_authenticationService.retrieveCode());
}