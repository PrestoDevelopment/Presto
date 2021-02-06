import 'package:presto_mobile/core/models/user_model.dart';
import 'package:presto_mobile/core/services/authentication_service.dart';
import 'package:presto_mobile/core/services/firestore_service.dart';
import 'package:presto_mobile/managers/referee_list_manager.dart';
import 'package:stacked/stacked.dart';

class RefereesListModel extends BaseViewModel {
  final AuthenticationService _authenticationService = AuthenticationService();
  final FireStoreService _fireStoreService = FireStoreService();
  RefereeListManager refereeListManager = RefereeListManager();

  void getRefereesDetails(UserModel user) async {
    setBusy(true);
    print("Getting list");

    if (user.referredTo.length > 0) {
      for (int i = 0; i < user.referredTo.length; i++) {
        UserModel userModel =
            await _fireStoreService.getUser(user.referredTo[i]);
        refereeListManager.addData(userModel.name, userModel.email,
            userModel.contact, userModel.referralCode);
      }
      setBusy(false);
    }
    setBusy(false);
  }
}
