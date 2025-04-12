enum UserRole {
  unknown("Unknown", 0),
  admin("Administrator", 1),
  user("User", 2),
  seller("Seller", 3);

  final String label;
  final int level;

  const UserRole(this.label, this.level);

  // this function responsible for returning respective UserRole values
  // This function is responsible for converting an int (which represents a role level) into a corresponding UserRole enum value.
  static UserRole fromLevel(int level) {
    return UserRole.values.firstWhere(
      (role) => role.level == level,
      orElse: () => UserRole.unknown,
    );
  }
}
