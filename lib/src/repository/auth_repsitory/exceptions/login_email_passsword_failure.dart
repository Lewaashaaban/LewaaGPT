class LoginWithEmailAndPasswordFailure {
  final String message;

  const LoginWithEmailAndPasswordFailure(
      [this.message = 'An_unknown error occured! ']);

  factory LoginWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'Email and pasword do not match':
        return LoginWithEmailAndPasswordFailure(
            'Email and pasword do not match');
      case 'invalid email':
        return LoginWithEmailAndPasswordFailure(
            'You have not signed up with this email before');
      case 'operation-not-allowed':
        return LoginWithEmailAndPasswordFailure(
            'Operation is not allowed. Please contact support');
      case 'user-disabled':
        return const LoginWithEmailAndPasswordFailure(
            'This user has been disabled. Pleasse onctact support for help');
      default:
        return const LoginWithEmailAndPasswordFailure();
    }
  }
}
