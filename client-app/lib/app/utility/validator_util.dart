class ValidatorUtil {
  /// Nickname Regex
  static const String _nicknameRegex = r'^[a-zA-Z0-9가-힣]{2,10}$';

  /// Email Regex
  static const String _emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

  /// Password Regex
  static const String _passwordRegex =
      r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$';

  /// Authentication Code Pattern
  static const String _authenticationCodeRegex = r'^[0-9]{6}$';

  static bool isValidNickname(String nickname) {
    final regex = RegExp(_nicknameRegex);
    return regex.hasMatch(nickname);
  }

  static bool isValidEmail(String email) {
    final regex = RegExp(_emailRegex);
    return regex.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    final regex = RegExp(_passwordRegex);
    return regex.hasMatch(password);
  }

  static bool isValidAuthenticationCode(String code) {
    final regex = RegExp(_authenticationCodeRegex);
    return regex.hasMatch(code);
  }
}
