import 'package:geolocator/geolocator.dart';

class UserModel {
  String name;
  String email;
  String contact;
  bool emailVerified;
  bool contactVerified;
  String referredBy;
  List<dynamic> referredTo;
  //Will Contain list of referral Codes of individuals whom he/she referred to.
  String referralCode;
  String deviceId;
  List<dynamic> transactionIds;
  Position userLocation;
  String personalScore;
  String communityScore;
  String notificationToken;
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
        notificationToken = null;

  UserModel.fromJson(Map<dynamic, dynamic> json)
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
        notificationToken = json['notificationToken'] ?? "";

  Map<dynamic, dynamic> toJson() => {
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
        'notificationToken': notificationToken
      };
}
