enum AccountMode {
  user,
  sponsor,
  organization,
  none
}

class LocalData {
  String? accessToken;
  String? refreshToken;
  AccountMode? accountMode;
  bool isFirstTimeOpenApp;
  bool isChosenFavorite;

  LocalData(this.accessToken, this.refreshToken, this.isFirstTimeOpenApp, this.isChosenFavorite, String value) :
      accountMode = accountModeFromString(value);

  factory LocalData.fromJson(Map<String, dynamic> json) {
    return LocalData(
      json['accessToken'],
      json['refreshToken'],
      json['isFirstTimeOpenApp'],
      json['isChosenFavorite'],
      json['accountMode'],
    );
  }

  Map<String, dynamic> toJson() => {
    'accessToken': accessToken,
    'refreshToken': refreshToken,
    'isFirstTimeOpenApp': isFirstTimeOpenApp,
    'accountMode': accountModeToString(accountMode),
    'isChosenFavorite': isChosenFavorite,
  };

  static AccountMode accountModeFromString(String? value) {
    switch (value) {
      case 'SPONSOR':
        return AccountMode.sponsor;
      case 'ORGANIZATION':
        return AccountMode.organization;
      case 'VOLUNTEER':
        return AccountMode.user;
      default:
        return AccountMode.none;
    }
  }

  static String accountModeToString(AccountMode? accountMode) {
    switch (accountMode) {
      case AccountMode.user:
        return 'VOLUNTEER';
      case AccountMode.sponsor:
        return 'SPONSOR';
      case AccountMode.organization:
        return 'ORGANIZATION';
      case AccountMode.none:
      default:
        return 'NONE';
    }
  }
}

