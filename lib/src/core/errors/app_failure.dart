class AppFailure implements Exception {
  final String message;

  AppFailure({this.message = 'Unknown Error Occured'});
}
