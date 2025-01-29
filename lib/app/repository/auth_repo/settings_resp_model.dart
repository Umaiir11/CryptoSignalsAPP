
class SettingsData {
  final AppSetting? appSetting;

  SettingsData({
    this.appSetting,
  });

  factory SettingsData.fromJson(Map<String, dynamic> json) {
    return SettingsData(
      appSetting: json['app_setting'] != null
          ? AppSetting.fromJson(json['app_setting'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'app_setting': appSetting?.toJson(),
    };
  }
}

class AppSetting {
  final int? id;
  final String? aboutUs;
  final String? privacyPolicy;
  final String? termsAndConditions;

  AppSetting({
    this.id,
    this.aboutUs,
    this.privacyPolicy,
    this.termsAndConditions,
  });

  factory AppSetting.fromJson(Map<String, dynamic> json) {
    return AppSetting(
      id: json['id'] as int?,
      aboutUs: json['about_us'] as String?,
      privacyPolicy: json['privacy_policy'] as String?,
      termsAndConditions: json['terms_and_conditions'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'about_us': aboutUs,
      'privacy_policy': privacyPolicy,
      'terms_and_conditions': termsAndConditions,
    };
  }
}
