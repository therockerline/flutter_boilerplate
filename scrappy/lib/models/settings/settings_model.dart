class SettingsModel {
  String id;
  String adminNickname;
  SettingsModel({this.id, this.adminNickname});

  factory SettingsModel.fromJson(Map<String, dynamic> json) {

    return SettingsModel(
        id: (json['_id'] as String),
        adminNickname:  (json['adminNickname'] as String),
    );
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['adminNickname'] = this.adminNickname;
    return data;
  }
}