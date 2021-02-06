class RefereeListManager {
  List<RefereeList> _refereeList = [];

  List<RefereeList> get refereeList => _refereeList;

  addData(String name, String email, String contact, String referralCode) {
    _refereeList.add(RefereeList(
      name: name,
      contact: contact,
      email: email,
      referralCode: referralCode,
    ));
  }
}

class RefereeList {
  final String name;
  final String email;
  final String referralCode;
  final String contact;

  RefereeList({
    this.name,
    this.email,
    this.referralCode,
    this.contact,
  });
}
