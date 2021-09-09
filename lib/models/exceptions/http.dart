class HTTPRequestException implements Exception {
  final String message;

  HTTPRequestException({this.message});

  @override
  String toString() {
    return message;
  }

  bool get isTokenValid {
    if (message.contains('expired')) return false;
    return true;
  }
}
