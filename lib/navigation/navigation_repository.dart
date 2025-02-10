import 'package:dermatosis/authentication/authentication_bloc.dart';
import 'package:dermatosis/authentication/authentication_page.dart';
import 'package:dermatosis/main.dart';

class NavigationRepository {
  final navigator = RM.navigate;
  GlobalKey<NavigatorState> get key => navigator.navigatorKey;

  /// dependents of [NavigatonBloc] bloc
  void update(Authentication authentication) {
    if (authentication.id == null) {
      toAndRemoveUntil(AuthenticationPage());
    } else {
      toAndRemoveUntil(HomePage());
    }
  }

  late final to = navigator.to;
  late final toDialog = navigator.toDialog;
  late final back = navigator.back;
  late final toAndRemoveUntil = navigator.toAndRemoveUntil;
}
