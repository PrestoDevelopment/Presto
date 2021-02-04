class TransCardManager {
  String _status;
  String _targetUser;

  void setStatus(String status) {
    _status = status;
  }

  void setTargetUser(String userTargeted) {
    _targetUser = userTargeted;
  }

  String getRefinedStatus() {
    if (_targetUser == 'Lender') {
      if (_status == 'Phase 1') {
        return "Upload Transcript";
      } else if (_status == 'Phase 2') {
        return "Money Sent";
      } else if (_status == 'Phase 3') {
        return "Money Sent";
      } else if (_status == 'Phase 4') {
        return "Confirm Payback";
      } else if (_status == 'Phase 5') {
        return "Transaction Done";
      } else {
        return "Please Refresh";
      }
    } else if (_targetUser == 'Borrower') {
      if (_status == 'Phase 1') {
        return "In Progress";
      } else if (_status == 'Phase 2') {
        return "Confirm";
      } else if (_status == 'Phase 3') {
        return "Payback";
      } else if (_status == 'Phase 4') {
        return "Transaction Done";
      } else if (_status == 'Phase 5') {
        return "Transaction Done";
      } else {
        return "Please Refresh";
      }
    } else {
      return "Please Refresh";
    }
  }
}
