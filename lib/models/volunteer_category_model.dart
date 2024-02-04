enum VolunteerCategory {
  education,
  emergencyPreparedness,
  environment,
  health,
  helpingNeighbours,
  strengtheningCommunities,
  researchWritingEditing,
}

String fromVolunteerCategoryToString(VolunteerCategory category) {
  switch(category) {
    case VolunteerCategory.education:
      return 'Giáo dục';
    case VolunteerCategory.emergencyPreparedness:
      return 'Phòng chống thiên tai';
    case VolunteerCategory.environment:
      return 'Môi trường';
    case VolunteerCategory.health:
      return 'Sức khỏe';
    case VolunteerCategory.helpingNeighbours:
      return 'Giúp đỡ hàng xóm';
    case VolunteerCategory.strengtheningCommunities:
      return 'Tăng cường cộng đồng';
    default:
      return 'Nghiên cứu, viết bài, biên tập';
  }
}

VolunteerCategory fromStringToVolunteerCategory(String category) {
  switch(category) {
    case 'education_type':
      return VolunteerCategory.education;
    case 'emergency_preparedness':
      return VolunteerCategory.emergencyPreparedness;
    case 'environment':
      return VolunteerCategory.environment;
    case 'healthy':
      return VolunteerCategory.health;
    case 'help_other':
      return VolunteerCategory.helpingNeighbours;
    case 'community_type':
      return VolunteerCategory.strengtheningCommunities;
    default:
      return VolunteerCategory.researchWritingEditing;
  }
}