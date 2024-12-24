
class InvalidKeyException implements Exception {
  final String message;

  InvalidKeyException(this.message);

  @override
  String toString() {
    return 'InvalidKeyException: $message';
  }
}
