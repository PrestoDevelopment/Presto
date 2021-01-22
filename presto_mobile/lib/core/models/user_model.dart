import 'package:geolocator/geolocator.dart';

class UserModel {
  String name;
  String email;
  String contact;
  bool emailVerified;
  bool contactVerified;
  String referredBy;
  List<dynamic> referredTo;
  List<int> paymentMethodsUsed;

  //Will Contain list of referral Codes of individuals whom he/she referred to.
  String referralCode;
  String deviceId;
  List<dynamic> transactionIds;
  Position userLocation;
  String personalScore;
  String communityScore;
  String notificationToken;
  int totalBorrowed;
  int totalLent;

  //Add transactions Lists

  UserModel({
    this.name,
    this.email,
    this.contact,
    this.deviceId,
    this.referralCode,
    this.referredBy,
    this.referredTo,
    this.transactionIds,
    this.contactVerified,
    this.emailVerified,
    this.userLocation,
    this.communityScore,
    this.personalScore,
    this.notificationToken,
    this.totalBorrowed,
    this.totalLent,
    this.paymentMethodsUsed,
  });

  UserModel.initial()
      : name = "test",
        email = "test@test.com",
        contact = "0123456789",
        referralCode = "TEST00",
        referredBy = "TEST01",
        referredTo = [],
        deviceId = "TESTDEVICEID",
        transactionIds = [],
        contactVerified = null,
        emailVerified = null,
        userLocation = null,
        communityScore = null,
        personalScore = null,
        totalBorrowed = 0,
        totalLent = 0,
        paymentMethodsUsed = [],
        notificationToken = null;

  UserModel.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? "",
        email = json['email'] ?? "",
        contact = json['contact'] ?? "",
        deviceId = json['deviceId'] ?? "",
        referralCode = json['referralCode'] ?? "",
        referredBy = json['referredBy'] ?? "",
        transactionIds = json['transactionIds'] ?? [],
        contactVerified = json['contactVerified'] ?? null,
        emailVerified = json['emailVerified'] ?? null,
        referredTo = json['referredTo'] ?? [],
        personalScore = json['personalScore'] ?? "",
        communityScore = json['communityScore'] ?? "",
        userLocation = json['userLocation'] ?? null,
        totalBorrowed = json['totalBorrowed'] ?? 0,
        totalLent = json['totalLent'] ?? 0,
        paymentMethodsUsed = json['paymentMethodsUsed'] ?? [0, 0, 0, 0, 0],
        notificationToken = json['notificationToken'] ?? "";

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'contact': contact,
        'deviceId': deviceId,
        'referralCode': referralCode,
        'referredBy': referredBy,
        'referredTo': referredTo,
        'emailVerified': emailVerified,
        'contactVerified': contactVerified,
        'personalScore': personalScore,
        'communityScore': communityScore,
        'transactionIds': transactionIds,
        'userLocation': userLocation,
        'notificationToken': notificationToken,
        'totalLent': totalLent,
        'totalBorrowed': totalBorrowed,
        'paymentMethodsUsed': paymentMethodsUsed,
      };

  @override
  bool operator ==(Object other) =>
      other is UserModel &&
      other.name == name &&
      other.email == email &&
      other.contact == contact &&
      other.deviceId == deviceId &&
      other.referralCode == referralCode &&
      other.referredBy == referredBy &&
      other.referredTo == referredTo &&
      other.emailVerified == emailVerified &&
      other.contactVerified == contactVerified &&
      other.personalScore == personalScore &&
      other.communityScore == communityScore &&
      other.transactionIds == transactionIds &&
      other.userLocation == userLocation &&
      other.totalLent == totalLent &&
      other.totalBorrowed == totalBorrowed &&
      other.paymentMethodsUsed == paymentMethodsUsed &&
      other.notificationToken == notificationToken;

  @override
  int get hashCode {
    int result = 17;
    result = result * 19 + name.hashCode;
    result = result * 19 + email.hashCode;
    result = result * 19 + contact.hashCode;
    result = result * 19 + deviceId.hashCode;
    result = result * 19 + referralCode.hashCode;
    result = result * 19 + referredTo.hashCode;
    result = result * 19 + referredBy.hashCode;
    result = result * 19 + emailVerified.hashCode;
    result = result * 19 + contactVerified.hashCode;
    result = result * 19 + personalScore.hashCode;
    result = result * 19 + communityScore.hashCode;
    result = result * 19 + transactionIds.hashCode;
    result = result * 19 + userLocation.hashCode;
    result = result * 19 + notificationToken.hashCode;
    result = result * 19 + totalBorrowed.hashCode;
    result = result * 19 + totalLent.hashCode;
    result = result * 19 + paymentMethodsUsed.hashCode;
    return result;
  }
}
