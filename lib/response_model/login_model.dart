class LoginModel {
  String? text;
  String? message;
  int? otp;
  List<Data>? data;

  LoginModel({this.text, this.message, this.otp, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    message = json['message'];
    otp = json['otp'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['message'] = this.message;
    data['otp'] = this.otp;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
 String? userRole;
  String? customerId;
  String? loginUserType;
  String? fullName;
  String? userName;
  String? lastName;
  String? aboutUs;
  String? group;
  String? email;
  String? password;
  String? mpinStatus;
  String? status;
  String? isVerified;
  String? created;
  String? modified;
  String? lastLoginDate;
  String? lastLogoutDate;
  String? lastLoginIp;
  String? thumbnail;
  String? address;
  String? locality;
  String? city;
  String? district;
  String? state;
  String? country;
String? postalCode;
  String? phoneNumber;
 String? otp;
  String? verifyCode;
  String? phoneVerificationCode;
  String? birthday;
  String? about;
  String? age;
  String? gender;
  String? referralKey;
  String? referBy;
  String? aadharNumber;
  String? panNumber;
  String? bankAcountHolderName;
  String? bankName;
  String? bankIfscCode;
  String? bankAccountNumber;
  String? bankUpiId;
  String? nomineeName;
  String? nomineeMobileNumber;
  String? nomineeEmail;
  String? nomineeBankAcountHolderName;
  String? nomineeBankName;
  String? nomineeBankIfscCode;
  String? nomineeBankAccountNumber;
  String? nomineeBankUpiId;
  String? shipAddFullName;
  String? shipAddCompanyName;
  String? shipAddStreetAddress;
  String? shipAddLocality;
  String? shipAddCity;
  String? shipAddState;
  String? shipAddCountry;
  String? shipAddPostalCode;
  String? billAddFullName;
  String? billAddCompanyName;
  String? billAddStreetAddress;
  String? billAddLocality;
  String? billAddCity;
  String? billAddState;
  String? billAddCountry;
  String? billAddPostalCode;
  String? billGstinNumber;
 String? fcmToken;
  String? notifyGoldRateFlag;
  String? userNotificationCount;

  Data(
      {this.id,
      this.userRole,
      this.customerId,
      this.loginUserType,
      this.fullName,
      this.userName,
      this.lastName,
      this.aboutUs,
      this.group,
      this.email,
      this.password,
      this.mpinStatus,
      this.status,
      this.isVerified,
      this.created,
      this.modified,
      this.lastLoginDate,
      this.lastLogoutDate,
      this.lastLoginIp,
      this.thumbnail,
      this.address,
      this.locality,
      this.city,
      this.district,
      this.state,
      this.country,
      this.postalCode,
      this.phoneNumber,
      this.otp,
      this.verifyCode,
      this.phoneVerificationCode,
      this.birthday,
      this.about,
      this.age,
      this.gender,
      this.referralKey,
      this.referBy,
      this.aadharNumber,
      this.panNumber,
      this.bankAcountHolderName,
      this.bankName,
      this.bankIfscCode,
      this.bankAccountNumber,
      this.bankUpiId,
      this.nomineeName,
      this.nomineeMobileNumber,
      this.nomineeEmail,
      this.nomineeBankAcountHolderName,
      this.nomineeBankName,
      this.nomineeBankIfscCode,
      this.nomineeBankAccountNumber,
      this.nomineeBankUpiId,
      this.shipAddFullName,
      this.shipAddCompanyName,
      this.shipAddStreetAddress,
      this.shipAddLocality,
      this.shipAddCity,
      this.shipAddState,
      this.shipAddCountry,
      this.shipAddPostalCode,
      this.billAddFullName,
      this.billAddCompanyName,
      this.billAddStreetAddress,
      this.billAddLocality,
      this.billAddCity,
      this.billAddState,
      this.billAddCountry,
      this.billAddPostalCode,
      this.billGstinNumber,
      this.fcmToken,
      this.notifyGoldRateFlag,
      this.userNotificationCount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userRole = json['user_role'];
    customerId = json['customer_id'];
    loginUserType = json['loginUserType'];
    fullName = json['full_name'];
    userName = json['user_name'];
    lastName = json['last_name'];
    aboutUs = json['about_us'];
    group = json['group'];
    email = json['email'];
    password = json['password'];
    mpinStatus = json['mpin_status'];
    status = json['status'];
    isVerified = json['is_verified'];
    created = json['created'];
    modified = json['modified'];
    lastLoginDate = json['last_login_date'];
    lastLogoutDate = json['last_logout_date'];
    lastLoginIp = json['last_login_ip'];
    thumbnail = json['thumbnail'];
    address = json['address'];
    locality = json['locality'];
    city = json['city'];
    district = json['district'];
    state = json['state'];
    country = json['country'];
    postalCode = json['postal_code'];
    phoneNumber = json['phone_number'];
    otp = json['otp'];
    verifyCode = json['verify_code'];
    phoneVerificationCode = json['phone_verification_code'];
    birthday = json['birthday'];
    about = json['about'];
    age = json['age'];
    gender = json['gender'];
    referralKey = json['referral_key'];
    referBy = json['refer_by'];
    aadharNumber = json['aadhar_number'];
    panNumber = json['pan_number'];
    bankAcountHolderName = json['bank_acount_holder_name'];
    bankName = json['bank_name'];
    bankIfscCode = json['bank_ifsc_code'];
    bankAccountNumber = json['bank_account_number'];
    bankUpiId = json['bank_upi_id'];
    nomineeName = json['nominee_name'];
    nomineeMobileNumber = json['nominee_mobile_number'];
    nomineeEmail = json['nominee_email'];
    nomineeBankAcountHolderName = json['nominee_bank_acount_holder_name'];
    nomineeBankName = json['nominee_bank_name'];
    nomineeBankIfscCode = json['nominee_bank_ifsc_code'];
    nomineeBankAccountNumber = json['nominee_bank_account_number'];
    nomineeBankUpiId = json['nominee_bank_upi_id'];
    shipAddFullName = json['ship_add_full_name'];
    shipAddCompanyName = json['ship_add_company_name'];
    shipAddStreetAddress = json['ship_add_street_address'];
    shipAddLocality = json['ship_add_locality'];
    shipAddCity = json['ship_add_city'];
    shipAddState = json['ship_add_state'];
    shipAddCountry = json['ship_add_country'];
    shipAddPostalCode = json['ship_add_postal_code'];
    billAddFullName = json['bill_add_full_name'];
    billAddCompanyName = json['bill_add_company_name'];
    billAddStreetAddress = json['bill_add_street_address'];
    billAddLocality = json['bill_add_locality'];
    billAddCity = json['bill_add_city'];
    billAddState = json['bill_add_state'];
    billAddCountry = json['bill_add_country'];
    billAddPostalCode = json['bill_add_postal_code'];
    billGstinNumber = json['bill_gstin_number'];
    fcmToken = json['fcm_token'];
    notifyGoldRateFlag = json['notify_gold_rate_flag'];
    userNotificationCount = json['user_notification_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_role'] = this.userRole;
    data['customer_id'] = this.customerId;
    data['loginUserType'] = this.loginUserType;
    data['full_name'] = this.fullName;
    data['user_name'] = this.userName;
    data['last_name'] = this.lastName;
    data['about_us'] = this.aboutUs;
    data['group'] = this.group;
    data['email'] = this.email;
    data['password'] = this.password;
    data['mpin_status'] = this.mpinStatus;
    data['status'] = this.status;
    data['is_verified'] = this.isVerified;
    data['created'] = this.created;
    data['modified'] = this.modified;
    data['last_login_date'] = this.lastLoginDate;
    data['last_logout_date'] = this.lastLogoutDate;
    data['last_login_ip'] = this.lastLoginIp;
    data['thumbnail'] = this.thumbnail;
    data['address'] = this.address;
    data['locality'] = this.locality;
    data['city'] = this.city;
    data['district'] = this.district;
    data['state'] = this.state;
    data['country'] = this.country;
    data['postal_code'] = this.postalCode;
    data['phone_number'] = this.phoneNumber;
    data['otp'] = this.otp;
    data['verify_code'] = this.verifyCode;
    data['phone_verification_code'] = this.phoneVerificationCode;
    data['birthday'] = this.birthday;
    data['about'] = this.about;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['referral_key'] = this.referralKey;
    data['refer_by'] = this.referBy;
    data['aadhar_number'] = this.aadharNumber;
    data['pan_number'] = this.panNumber;
    data['bank_acount_holder_name'] = this.bankAcountHolderName;
    data['bank_name'] = this.bankName;
    data['bank_ifsc_code'] = this.bankIfscCode;
    data['bank_account_number'] = this.bankAccountNumber;
    data['bank_upi_id'] = this.bankUpiId;
    data['nominee_name'] = this.nomineeName;
    data['nominee_mobile_number'] = this.nomineeMobileNumber;
    data['nominee_email'] = this.nomineeEmail;
    data['nominee_bank_acount_holder_name'] = this.nomineeBankAcountHolderName;
    data['nominee_bank_name'] = this.nomineeBankName;
    data['nominee_bank_ifsc_code'] = this.nomineeBankIfscCode;
    data['nominee_bank_account_number'] = this.nomineeBankAccountNumber;
    data['nominee_bank_upi_id'] = this.nomineeBankUpiId;
    data['ship_add_full_name'] = this.shipAddFullName;
    data['ship_add_company_name'] = this.shipAddCompanyName;
    data['ship_add_street_address'] = this.shipAddStreetAddress;
    data['ship_add_locality'] = this.shipAddLocality;
    data['ship_add_city'] = this.shipAddCity;
    data['ship_add_state'] = this.shipAddState;
    data['ship_add_country'] = this.shipAddCountry;
    data['ship_add_postal_code'] = this.shipAddPostalCode;
    data['bill_add_full_name'] = this.billAddFullName;
    data['bill_add_company_name'] = this.billAddCompanyName;
    data['bill_add_street_address'] = this.billAddStreetAddress;
    data['bill_add_locality'] = this.billAddLocality;
    data['bill_add_city'] = this.billAddCity;
    data['bill_add_state'] = this.billAddState;
    data['bill_add_country'] = this.billAddCountry;
    data['bill_add_postal_code'] = this.billAddPostalCode;
    data['bill_gstin_number'] = this.billGstinNumber;
    data['fcm_token'] = this.fcmToken;
    data['notify_gold_rate_flag'] = this.notifyGoldRateFlag;
    data['user_notification_count'] = this.userNotificationCount;
    return data;
  }
}
