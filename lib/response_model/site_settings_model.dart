class SiteSettingsModel {
  String? text;
  String? message;
  List<Data>? data;

  SiteSettingsModel({this.text, this.message, this.data});

  SiteSettingsModel.fromJson(Map<String, dynamic> json) {
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
  String? siteUrl;
  String? siteContactMail;
  String? siteContactNumber;
  String? siteContactWhatsapp;
  String? siteContactLandline;
  String? siteGst;
  String? siteRegNo;
  String? siteDefaultCountry;
  String? siteDefaultLanguage;
  String? siteDefaultCurrency;
  String? siteDefaultTimezone;
  String? siteMailAddress;
  String? siteRegisteredAddress;
  String? emailTitle;
  String? logoImage;
  String? siteLogo;
  String? siteVLogo;
  String? siteInvoiceLogo;
  String? feviconImage;
  String? notification;
  String? fcmWebServerKey;
  String? purchaseGoldContent;
  String? deleteAccountContent;
  String? deleteAccountAlertContent;
  String? quickPaymentMethod;
  String? siteMode;
  String? upiQrCodes;
  String? fbAccessToken;
  String? whatsappNotifyNumbers;
  Null? homePopupImg;
  Null? homePopupContent;
  String? mobWelcomeLogo;
  String? mobHomeLogo;
  String? headerLogo;

  Data(
      {this.id,
      this.siteUrl,
      this.siteContactMail,
      this.siteContactNumber,
      this.siteContactWhatsapp,
      this.siteContactLandline,
      this.siteGst,
      this.siteRegNo,
      this.siteDefaultCountry,
      this.siteDefaultLanguage,
      this.siteDefaultCurrency,
      this.siteDefaultTimezone,
      this.siteMailAddress,
      this.siteRegisteredAddress,
      this.emailTitle,
      this.logoImage,
      this.siteLogo,
      this.siteVLogo,
      this.siteInvoiceLogo,
      this.feviconImage,
      this.notification,
      this.fcmWebServerKey,
      this.purchaseGoldContent,
      this.deleteAccountContent,
      this.deleteAccountAlertContent,
      this.quickPaymentMethod,
      this.siteMode,
      this.upiQrCodes,
      this.fbAccessToken,
      this.whatsappNotifyNumbers,
      this.homePopupImg,
      this.homePopupContent,
      this.mobWelcomeLogo,
      this.mobHomeLogo,
      this.headerLogo});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    siteUrl = json['site_url'];
    siteContactMail = json['site_contact_mail'];
    siteContactNumber = json['site_contact_number'];
    siteContactWhatsapp = json['site_contact_whatsapp'];
    siteContactLandline = json['site_contact_landline'];
    siteGst = json['site_gst'];
    siteRegNo = json['site_reg_no'];
    siteDefaultCountry = json['site_default_country'];
    siteDefaultLanguage = json['site_default_language'];
    siteDefaultCurrency = json['site_default_currency'];
    siteDefaultTimezone = json['site_default_timezone'];
    siteMailAddress = json['site_mail_address'];
    siteRegisteredAddress = json['site_registered_address'];
    emailTitle = json['email_title'];
    logoImage = json['logo_image'];
    siteLogo = json['site_logo'];
    siteVLogo = json['site_v_logo'];
    siteInvoiceLogo = json['site_invoice_logo'];
    feviconImage = json['fevicon_image'];
    notification = json['notification'];
    fcmWebServerKey = json['fcm_web_server_key'];
    purchaseGoldContent = json['purchase_gold_content'];
    deleteAccountContent = json['delete_account_content'];
    deleteAccountAlertContent = json['delete_account_alert_content'];
    quickPaymentMethod = json['quick_payment_method'];
    siteMode = json['site_mode'];
    upiQrCodes = json['upi_qr_codes'];
    fbAccessToken = json['fb_access_token'];
    whatsappNotifyNumbers = json['whatsapp_notify_numbers'];
    homePopupImg = json['home_popup_img'];
    homePopupContent = json['home_popup_content'];
    mobWelcomeLogo = json['mob_welcome_logo'];
    mobHomeLogo = json['mob_home_logo'];
    headerLogo = json['header-logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['site_url'] = this.siteUrl;
    data['site_contact_mail'] = this.siteContactMail;
    data['site_contact_number'] = this.siteContactNumber;
    data['site_contact_whatsapp'] = this.siteContactWhatsapp;
    data['site_contact_landline'] = this.siteContactLandline;
    data['site_gst'] = this.siteGst;
    data['site_reg_no'] = this.siteRegNo;
    data['site_default_country'] = this.siteDefaultCountry;
    data['site_default_language'] = this.siteDefaultLanguage;
    data['site_default_currency'] = this.siteDefaultCurrency;
    data['site_default_timezone'] = this.siteDefaultTimezone;
    data['site_mail_address'] = this.siteMailAddress;
    data['site_registered_address'] = this.siteRegisteredAddress;
    data['email_title'] = this.emailTitle;
    data['logo_image'] = this.logoImage;
    data['site_logo'] = this.siteLogo;
    data['site_v_logo'] = this.siteVLogo;
    data['site_invoice_logo'] = this.siteInvoiceLogo;
    data['fevicon_image'] = this.feviconImage;
    data['notification'] = this.notification;
    data['fcm_web_server_key'] = this.fcmWebServerKey;
    data['purchase_gold_content'] = this.purchaseGoldContent;
    data['delete_account_content'] = this.deleteAccountContent;
    data['delete_account_alert_content'] = this.deleteAccountAlertContent;
    data['quick_payment_method'] = this.quickPaymentMethod;
    data['site_mode'] = this.siteMode;
    data['upi_qr_codes'] = this.upiQrCodes;
    data['fb_access_token'] = this.fbAccessToken;
    data['whatsapp_notify_numbers'] = this.whatsappNotifyNumbers;
    data['home_popup_img'] = this.homePopupImg;
    data['home_popup_content'] = this.homePopupContent;
    data['mob_welcome_logo'] = this.mobWelcomeLogo;
    data['mob_home_logo'] = this.mobHomeLogo;
    data['header-logo'] = this.headerLogo;
    return data;
  }
}
