enum AccountMode {
  user,
  sponsor,
  organization,
  none
}

AccountMode? accountModeFromString(String? value) {
  switch (value) {
    case 'sponsor':
      return AccountMode.sponsor;
    case 'organization':
      return AccountMode.organization;
    case 'user':
      return AccountMode.user;
    case 'none':
      return AccountMode.none;
  }
}

String accountModeToString(AccountMode accountMode) {
  switch (accountMode) {
    case AccountMode.user:
      return 'user';
    case AccountMode.sponsor:
      return 'sponsor';
    case AccountMode.organization:
      return 'organization';
    case AccountMode.none:
      return 'none';
  }
}