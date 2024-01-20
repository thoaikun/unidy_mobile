enum VolunteerCategory {
  education,
  emergencyPreparedness,
  environment,
  health,
  helpingNeighbours,
  strengtheningCommunities,
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
  }
}