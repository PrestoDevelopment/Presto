class RefereeListManager{
  String _name;
  String _email;
  String _referralCode;
  String _contact;

  void setData(String name, String email, String contact,String referralCode){
    _name = name;
    _email = email;
    _referralCode = referralCode;
    _contact = contact;
  }

  String getName(){
    return _name;
  }

  String getEmail(){
    return _email;
  }

  String getContact(){
    return _contact;
  }

  String getReferralCode(){
    return _referralCode;
  }
}