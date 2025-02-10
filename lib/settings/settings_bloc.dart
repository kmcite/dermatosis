import '../main.dart';

final SettingsBloc settingsBloc = SettingsBloc();

class SettingsBloc {
  late final settingsRM = RM.inject(
    () => Settings(),
  );
  String get clinicName => settings().clinicName;

  Settings settings([Settings? _settings]) {
    if (_settings != null)
      settingsRM
        ..state = _settings
        ..notify();
    return settingsRM.state;
  }

  ThemeMode themeMode([ThemeMode? _themeMode]) {
    if (_themeMode != null)
      settings(
        settings()..themeModeIndex = ThemeMode.values.indexOf(_themeMode),
      );
    return ThemeMode.values[settings().themeModeIndex];
  }

  setClinicName(String value) {
    settings(settings()..clinicName = value);
  }
}

class Settings {
  int themeModeIndex = 0;
  String clinicName = '';

  ThemeMode get themeMode => ThemeMode.values[themeModeIndex];
  set themeMode(ThemeMode value) {
    themeModeIndex = ThemeMode.values.indexOf(value);
  }
}
