import 'package:dermatosis/authentication/authentication_repository.dart';
import 'package:dermatosis/doctor/doctor.dart';
import 'package:dermatosis/main.dart';
import 'package:dermatosis/navigation/navigation_repository.dart';
import 'package:dermatosis/navigation/navigation_bloc.dart';

import '../patients/patients_repository.dart';

enum UserType { doctor, patient }

class Authentication {
  int? id;
  UserType type = UserType.doctor;
  String name = '';
  String password = '';
  String email = '';

  bool get invalidCredentials => email == '' || password == '';
  @override
  String toString() {
    return ''
        'id: $id, '
        'type: $type, '
        'name: $name, '
        'password: $password, '
        'email: $email, '
        'invalidCredentials: $invalidCredentials';
  }
}

final authenticationBloc = AuthenticationBloc();

class AuthenticationBloc {
  NavigationRepository get _navigationRepository => navigationRepository;
  AuthenticationRepository get _authenticationRepository =>
      authenticationRepositoryRM.state;

  final authenticationRM = RM.inject<Authentication>(() => Authentication());

  Authentication get authentication => authenticationRM.state;
  bool get isAuthenticated => authentication.id != null;
  bool get isNotAuthenticated => !isAuthenticated;

  void set authentication(Authentication value) {
    _authenticationRepository.authentication(value);
    authenticationRM
      ..state = _authenticationRepository.authentication()
      ..notify();
  }

  void login() {
    if (userType() == UserType.doctor) {
      final doctor = doctorsRepository.search(authentication.email);
      if (doctor != null) {
        id = doctor.id;
      }
    } else {
      final patient = patientsRepository.search(authentication.email);
      if (patient != null) {
        id = patient.id;
      }
    }
    _navigationRepository.update(authentication);
  }

  void logout() {
    id = null;
    _navigationRepository.update(authentication);
  }

  int get tabIndex {
    return switch (userType()) {
      UserType.doctor => 0,
      UserType.patient => 1,
    };
  }

  void setTabIndex(int value) {
    if (value == 0) {
      userType(UserType.doctor);
    } else {
      userType(UserType.patient);
    }
  }

  /// state modifier
  UserType userType([UserType? type]) {
    if (type != null) {
      authentication = authentication..type = type;
    }
    return authentication.type;
  }

  int? get id => authentication.id;

  bool get invalidCredentials => authentication.invalidCredentials;
  set id(int? value) => authentication = authentication..id = value;

  void onNameChange(value) {
    authentication = authentication..name = value;
  }

  void onEmailChange(value) {
    authentication = authentication..email = value;
  }

  void onPasswordChange(value) {
    authentication = authentication..password = value;
  }
}
