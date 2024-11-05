class ForgotMpinModel {
  String? text;
  String? message;
  int? otp;
  Data? data;

  ForgotMpinModel({this.text, this.message, this.otp, this.data});

  ForgotMpinModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    message = json['message'];
    otp = json['otp'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['message'] = this.message;
    data['otp'] = this.otp;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
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
  Null? otp;
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
  String? fcmToken;

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
      this.fcmToken});

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
    fcmToken = json['fcm_token'];
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
    data['fcm_token'] = this.fcmToken;
    return data;
  }
}
