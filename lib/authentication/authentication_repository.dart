import 'package:dermatosis/authentication/authentication_bloc.dart';
import 'package:dermatosis/main.dart';

class AuthenticationRepository {
  Authentication _authentication = Authentication();

  Authentication authentication([Authentication? auth]) {
    if (auth != null) {
      _authentication = auth;
    }
    return _authentication;
  }

  bool get isAutheticated => authentication().id != null;
}

final authenticationRepositoryRM = RM.inject(() => AuthenticationRepository());
