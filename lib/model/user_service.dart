class AppUser {
  String username;
  AppUser(this.username);
}

class UserService {
  AppUser getUser() {
    return AppUser("Munseok");
  }
}
