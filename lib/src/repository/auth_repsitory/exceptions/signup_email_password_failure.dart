// ignore_for_file: prefer_const_constructors

class SignupWithEmailAndPasswordFailure {
  final String message;

  const SignupWithEmailAndPasswordFailure(
      [this.message = 'An_unknown error occured! ']);

  factory SignupWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'weak password':
        return SignupWithEmailAndPasswordFailure(
            'Please enter a strong password');
      case 'invalid email':
        return SignupWithEmailAndPasswordFailure(
            'Email is not valid or badly formatted');
      case 'email-already-in-use':
        return SignupWithEmailAndPasswordFailure(
            'An account already exists for that email');
      case 'operation-not-allowed':
        return SignupWithEmailAndPasswordFailure(
            'Operation is not allowed. Please contact support');
      case 'user-disabled':
        return const SignupWithEmailAndPasswordFailure(
            'This user has been disabled. Pleasse onctact support for help');
      default:
        return const SignupWithEmailAndPasswordFailure();
    }
  }
}
