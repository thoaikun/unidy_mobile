enum EPopupMenuOption {
  logout,
  organizationMode,
  sponsorMode,
  volunteerMode
}

class IPopupMenuItem {
  EPopupMenuOption value;
  String label;
  IPopupMenuItem({ required this.value, required this.label });
}