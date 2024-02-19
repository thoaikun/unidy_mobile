enum VolunteerCategoryKey {
  education,
  emergencyPreparedness,
  environment,
  health,
  helpingNeighbours,
  strengtheningCommunities,
  researchWritingEditing,
}

class VolunteerCategory {
  VolunteerCategoryKey key;

  VolunteerCategory(this.key);

  static final List<VolunteerCategory> categories = [
    VolunteerCategory(VolunteerCategoryKey.education),
    VolunteerCategory(VolunteerCategoryKey.emergencyPreparedness),
    VolunteerCategory(VolunteerCategoryKey.environment),
    VolunteerCategory(VolunteerCategoryKey.health),
    VolunteerCategory(VolunteerCategoryKey.helpingNeighbours),
    VolunteerCategory(VolunteerCategoryKey.strengtheningCommunities),
    VolunteerCategory(VolunteerCategoryKey.researchWritingEditing),
  ];

  static VolunteerCategory fromKey(VolunteerCategoryKey key) {
    return VolunteerCategory(key);
  }

  static VolunteerCategory fromString(String category) {
    switch(category) {
      case 'education_type':
        return VolunteerCategory(VolunteerCategoryKey.education);
      case 'emergency_preparedness':
        return VolunteerCategory(VolunteerCategoryKey.emergencyPreparedness);
      case 'environment':
        return VolunteerCategory(VolunteerCategoryKey.environment);
      case 'healthy':
        return VolunteerCategory(VolunteerCategoryKey.health);
      case 'help_other':
        return VolunteerCategory(VolunteerCategoryKey.helpingNeighbours);
      case 'community_type':
        return VolunteerCategory(VolunteerCategoryKey.strengtheningCommunities);
      default:
        return VolunteerCategory(VolunteerCategoryKey.researchWritingEditing);
    }
  }

  @override
  String toString() {
    switch(key) {
      case VolunteerCategoryKey.education:
        return 'Giáo dục';
      case VolunteerCategoryKey.emergencyPreparedness:
        return 'Phòng chống thiên tai';
      case VolunteerCategoryKey.environment:
        return 'Môi trường';
      case VolunteerCategoryKey.health:
        return 'Sức khỏe';
      case VolunteerCategoryKey.helpingNeighbours:
        return 'Giúp đỡ hàng xóm';
      case VolunteerCategoryKey.strengtheningCommunities:
        return 'Tăng cường cộng đồng';
      default:
        return 'Nghiên cứu, viết bài, biên tập';
    }
  }
}