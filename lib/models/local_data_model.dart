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

  LocalData(this.accessToken, this.refreshToken, this.isFirstTimeOpenApp, String value) :
      accountMode = accountModeFromString(value);

  factory LocalData.fromJson(Map<String, dynamic> json) {
    return LocalData(
      json['accessToken'],
      json['refreshToken'],
      json['isFirstTimeOpenApp'],
      json['accountMode']
    );
  }

  Map<String, dynamic> toJson() => {
    'accessToken': accessToken,
    'refreshToken': refreshToken,
    'isFirstTimeOpenApp': isFirstTimeOpenApp,
    'accountMode': accountModeToString(accountMode)
  };

  static AccountMode? accountModeFromString(String? value) {
    switch (value) {
      case 'sponsor':
        return AccountMode.sponsor;
      case 'organization':
        return AccountMode.organization;
      case 'user':
        return AccountMode.user;
      case 'none':
        return AccountMode.none;
      default:
        return null;
    }
  }

  static String accountModeToString(AccountMode? accountMode) {
    switch (accountMode) {
      case AccountMode.user:
        return 'user';
      case AccountMode.sponsor:
        return 'sponsor';
      case AccountMode.organization:
        return 'organization';
      case AccountMode.none:
        return 'none';
      default:
        return 'none';
    }
  }
}

