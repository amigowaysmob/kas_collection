class RegisterModel {
  String? text;
  String? message;
  int? data;

  RegisterModel({this.text, this.message, this.data});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}
