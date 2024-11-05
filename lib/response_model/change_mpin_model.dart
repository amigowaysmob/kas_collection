class ChangeMpinModel {
  String? text;
  String? message;
  List<Data>? data;

  ChangeMpinModel({this.text, this.message, this.data});

  ChangeMpinModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    message = json['message'];
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
  String? memberType;
  String? loginUserType;
  String? fullName;
  String? guardianName;
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
  Null? locality;
  String? city;
  String? division;
  String? area;
  String? district;
  String? state;
  String? country;
  String? postalCode;
  String? landmark;
  String? phoneNumber;
  String? whatsappNumber;
  Null? otp;
  Null? verifyCode;
  Null? phoneVerificationCode;
  String? birthday;
  Null? about;
  Null? age;
  String? gender;
  String? referralKey;
  String? referBy;
  String? aadharNumber;
  String? panNumber;
 String? photo;
  String? aadharCardFront;
  Null? aadharCardBack;
  Null? panCardFront;
  Null? panCardBack;
  Null? bankAcountHolderName;
  String? bankName;
  String? bankIfscCode;
  String? bankAccountNumber;
  String? bankUpiId;
  Null? chequeNo;
  String? chequeLeaf;
  String? nomineeName;
  String? nomineeMobileNumber;
  String? nomineeEmail;
  Null? nomineeGender;
  Null? nomineeRelationship;
  Null? nomineeAddress;
  Null? nomineeLocality;
  Null? nomineeCity;
  Null? nomineeLandmark;
  Null? nomineePhoto;
  Null? nomineeAadharCardFront;
  Null? nomineeAadharCardBack;
  Null? nomineePanCardFront;
  Null? nomineePanCardBack;
  Null? nomineeBankAcountHolderName;
  String? nomineeBankName;
  String? nomineeBankIfscCode;
  String? nomineeBankAccountNumber;
  String? nomineeBankUpiId;
  String? fcmToken;
  Null? passbookVerifyNo;
  String? approvalRequested;
  String? addedBy;

  Data(
      {this.id,
      this.userRole,
      this.customerId,
      this.memberType,
      this.loginUserType,
      this.fullName,
      this.guardianName,
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
      this.division,
      this.area,
      this.district,
      this.state,
      this.country,
      this.postalCode,
      this.landmark,
      this.phoneNumber,
      this.whatsappNumber,
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
      this.photo,
      this.aadharCardFront,
      this.aadharCardBack,
      this.panCardFront,
      this.panCardBack,
      this.bankAcountHolderName,
      this.bankName,
      this.bankIfscCode,
      this.bankAccountNumber,
      this.bankUpiId,
      this.chequeNo,
      this.chequeLeaf,
      this.nomineeName,
      this.nomineeMobileNumber,
      this.nomineeEmail,
      this.nomineeGender,
      this.nomineeRelationship,
      this.nomineeAddress,
      this.nomineeLocality,
      this.nomineeCity,
      this.nomineeLandmark,
      this.nomineePhoto,
      this.nomineeAadharCardFront,
      this.nomineeAadharCardBack,
      this.nomineePanCardFront,
      this.nomineePanCardBack,
      this.nomineeBankAcountHolderName,
      this.nomineeBankName,
      this.nomineeBankIfscCode,
      this.nomineeBankAccountNumber,
      this.nomineeBankUpiId,
      this.fcmToken,
      this.passbookVerifyNo,
      this.approvalRequested,
      this.addedBy});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userRole = json['user_role'];
    customerId = json['customer_id'];
    memberType = json['member_type'];
    loginUserType = json['loginUserType'];
    fullName = json['full_name'];
    guardianName = json['guardian_name'];
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
    division = json['division'];
    area = json['area'];
    district = json['district'];
    state = json['state'];
    country = json['country'];
    postalCode = json['postal_code'];
    landmark = json['landmark'];
    phoneNumber = json['phone_number'];
    whatsappNumber = json['whatsapp_number'];
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
    photo = json['photo'];
    aadharCardFront = json['aadhar_card_front'];
    aadharCardBack = json['aadhar_card_back'];
    panCardFront = json['pan_card_front'];
    panCardBack = json['pan_card_back'];
    bankAcountHolderName = json['bank_acount_holder_name'];
    bankName = json['bank_name'];
    bankIfscCode = json['bank_ifsc_code'];
    bankAccountNumber = json['bank_account_number'];
    bankUpiId = json['bank_upi_id'];
    chequeNo = json['cheque_no'];
    chequeLeaf = json['cheque_leaf'];
    nomineeName = json['nominee_name'];
    nomineeMobileNumber = json['nominee_mobile_number'];
    nomineeEmail = json['nominee_email'];
    nomineeGender = json['nominee_gender'];
    nomineeRelationship = json['nominee_relationship'];
    nomineeAddress = json['nominee_address'];
    nomineeLocality = json['nominee_locality'];
    nomineeCity = json['nominee_city'];
    nomineeLandmark = json['nominee_landmark'];
    nomineePhoto = json['nominee_photo'];
    nomineeAadharCardFront = json['nominee_aadhar_card_front'];
    nomineeAadharCardBack = json['nominee_aadhar_card_back'];
    nomineePanCardFront = json['nominee_pan_card_front'];
    nomineePanCardBack = json['nominee_pan_card_back'];
    nomineeBankAcountHolderName = json['nominee_bank_acount_holder_name'];
    nomineeBankName = json['nominee_bank_name'];
    nomineeBankIfscCode = json['nominee_bank_ifsc_code'];
    nomineeBankAccountNumber = json['nominee_bank_account_number'];
    nomineeBankUpiId = json['nominee_bank_upi_id'];
    fcmToken = json['fcm_token'];
    passbookVerifyNo = json['passbook_verify_no'];
    approvalRequested = json['approval_requested'];
    addedBy = json['added_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_role'] = this.userRole;
    data['customer_id'] = this.customerId;
    data['member_type'] = this.memberType;
    data['loginUserType'] = this.loginUserType;
    data['full_name'] = this.fullName;
    data['guardian_name'] = this.guardianName;
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
    data['division'] = this.division;
    data['area'] = this.area;
    data['district'] = this.district;
    data['state'] = this.state;
    data['country'] = this.country;
    data['postal_code'] = this.postalCode;
    data['landmark'] = this.landmark;
    data['phone_number'] = this.phoneNumber;
    data['whatsapp_number'] = this.whatsappNumber;
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
    data['photo'] = this.photo;
    data['aadhar_card_front'] = this.aadharCardFront;
    data['aadhar_card_back'] = this.aadharCardBack;
    data['pan_card_front'] = this.panCardFront;
    data['pan_card_back'] = this.panCardBack;
    data['bank_acount_holder_name'] = this.bankAcountHolderName;
    data['bank_name'] = this.bankName;
    data['bank_ifsc_code'] = this.bankIfscCode;
    data['bank_account_number'] = this.bankAccountNumber;
    data['bank_upi_id'] = this.bankUpiId;
    data['cheque_no'] = this.chequeNo;
    data['cheque_leaf'] = this.chequeLeaf;
    data['nominee_name'] = this.nomineeName;
    data['nominee_mobile_number'] = this.nomineeMobileNumber;
    data['nominee_email'] = this.nomineeEmail;
    data['nominee_gender'] = this.nomineeGender;
    data['nominee_relationship'] = this.nomineeRelationship;
    data['nominee_address'] = this.nomineeAddress;
    data['nominee_locality'] = this.nomineeLocality;
    data['nominee_city'] = this.nomineeCity;
    data['nominee_landmark'] = this.nomineeLandmark;
    data['nominee_photo'] = this.nomineePhoto;
    data['nominee_aadhar_card_front'] = this.nomineeAadharCardFront;
    data['nominee_aadhar_card_back'] = this.nomineeAadharCardBack;
    data['nominee_pan_card_front'] = this.nomineePanCardFront;
    data['nominee_pan_card_back'] = this.nomineePanCardBack;
    data['nominee_bank_acount_holder_name'] = this.nomineeBankAcountHolderName;
    data['nominee_bank_name'] = this.nomineeBankName;
    data['nominee_bank_ifsc_code'] = this.nomineeBankIfscCode;
    data['nominee_bank_account_number'] = this.nomineeBankAccountNumber;
    data['nominee_bank_upi_id'] = this.nomineeBankUpiId;
    data['fcm_token'] = this.fcmToken;
    data['passbook_verify_no'] = this.passbookVerifyNo;
    data['approval_requested'] = this.approvalRequested;
    data['added_by'] = this.addedBy;
    return data;
  }
}
