class AuthenticationException implements Exception {
  final String message;
  final String code;

  AuthenticationException({this.message, this.code});

  @override
  String toString() {
    String authenticationMaessage = _generateAuthenticationMEssage(message);

    print('Authenticattion Error $code: $authenticationMaessage');
    return authenticationMaessage;
  }

  String _generateAuthenticationMEssage(message) {
    const Map<String, String> ERROR_MESSAGE = {
      'EMAIL_EXIST': 'Oppss.. email already exist',
      'EMAIL_NOT_FOUND': 'Could not find user with that email',
      'INVALID_EMAIL': 'Email or password you entered is not valid',
      'INVALID_PASSWORD': 'Invalid password',
      'WEAK_PASSWORD': 'Password you entered is weak',
    };

    return ERROR_MESSAGE[message];
  }
}
