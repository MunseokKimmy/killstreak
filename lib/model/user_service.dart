class User {
  String username;
  User(this.username);
}

class UserService {
  User getUser() {
    return User("Munseok");
  }
}
