import 'package:dermatosis/main.dart';
import 'package:dermatosis/navigation/navigation_repository.dart';

final NavigationRepository navigationRepository = NavigationRepository();

final NavigationBloc navigator = NavigationBloc();

class NavigationBloc {
  NavigationRepository get _navigationRepository => navigationRepository;

  GlobalKey<NavigatorState> get key => _navigationRepository.key;

  late final to = _navigationRepository.to;
  late final toDialog = _navigationRepository.toDialog;
  late final back = _navigationRepository.back;
  late final toAndRemoveUntil = _navigationRepository.toAndRemoveUntil;
}
