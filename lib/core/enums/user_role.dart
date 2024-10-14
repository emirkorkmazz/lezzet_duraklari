enum UserRole {
  businessOwner,
  user,
  admin,
}

extension UserRoleExtension on UserRole {
  String get toStringValue {
    switch (this) {
      case UserRole.businessOwner:
        return 'BusinessOwner';
      case UserRole.user:
        return 'User';
      case UserRole.admin:
        return 'Admin';
    }
  }
}
