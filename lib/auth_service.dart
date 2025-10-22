class AuthService {
  static final Map<String, String> _users = {}; // email -> password

  static bool signUp(String email, String password) {
    if (_users.containsKey(email)) return false;
    _users[email] = password;
    return true;
  }

  static bool signIn(String email, String password) {
    return _users[email] == password;
  }
}
