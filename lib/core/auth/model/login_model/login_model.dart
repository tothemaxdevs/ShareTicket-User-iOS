class LoginResult {
  final String otp;
  final String token;
  final String data;
  final String type;
  final String remainingTime;
  final String id;

  LoginResult(
      {required this.otp,
      required this.token,
      required this.data,
      required this.type,
      required this.remainingTime,
      required this.id});
}
