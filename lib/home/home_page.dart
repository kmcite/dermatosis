import 'package:dermatosis/home/add_patient_dialog.dart';
import 'package:dermatosis/objectbox.g.dart';
import 'package:dermatosis/patients/patient_page.dart';
import 'package:dermatosis/patients/patients_bloc.dart';
import 'package:dermatosis/patients/patients_page.dart';
import 'package:dermatosis/patients/patients_repository.dart';
import 'package:dermatosis/main.dart';
import 'package:dermatosis/search/search_page.dart';
import 'package:dermatosis/settings/settings_page.dart';
import 'package:forui/forui.dart';
import '../navigation/navigation_bloc.dart';
import '../patients/patient.dart';

class HomePage extends UI {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: const Text('home'),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FLabel(
            axis: Axis.vertical,
            label: settingsBloc.clinicName.text(),
            child: 'emeregncy and trauma center'.text(),
            description:
                '${todaysPatientsBloc.number} patients served today'.text(),
          ).pad(),
          FLabel(
            axis: Axis.vertical,
            label: Text('quick actions'),
            child: Row(
              children: [
                FButton.icon(
                  onPress: () async {
                    final patient = await navigator.toDialog<Patient>(
                      AddPatientDialog(),
                    );
                    if (patient != null) patientsBloc.put(patient);
                  },
                  child: Icon(Icons.add_box_sharp),
                ),
                FButton.icon(
                  onPress: () => navigator.to(SearchPage()),
                  child: Icon(Icons.search),
                ),
                FButton.icon(
                  onPress: () => navigator.to(PatientsPage()),
                  child: Icon(Icons.list),
                ),
                FButton.icon(
                  onPress: () => navigator.to(SettingsPage()),
                  child: Icon(Icons.settings),
                ),
              ],
            ),
          ).pad(),
          FLabel(
            axis: Axis.vertical,
            label: Text('patients'),
            child: '${patientsBloc.patients.length}'.text(),
            description: 'officer: DrAdn'.text(),
          ).pad(),
          FLabel(
            axis: Axis.vertical,
            label: 'recent modifications'.text(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: recentlyModifiedBloc.recentlyModifiedPatients.map(
                (patient) {
                  return FButton(
                    onPress: () {
                      navigator.to(
                        PatientPage(patient.id),
                      );
                    },
                    label: '${patient.name}'.text(),
                  );
                },
              ).toList(),
            ),
            description:
                '${recentlyModifiedBloc.number} recently modified.'.text(),
          ).pad(),
        ],
      ),
    );
  }
}

final todaysPatientsBloc = TodaysPatientsBloc();

class TodaysPatientsBloc {
  PatientsRepository get _patientsRepository => patientsRepository;
  int get number {
    final today = DateTime.now();
    final oneDayBefore = today.subtract(const Duration(days: 1));
    return _patientsRepository
        .query(
          Patient_.presentation.betweenDate(today, oneDayBefore),
        )
        .build()
        .find()
        .length;
  }
}

final recentlyModifiedBloc = RecentlyModifiedBloc();

/// recently modified patients are patients which are
/// modified recently and at least contains 5 patients.

class RecentlyModifiedBloc {
  PatientsRepository get _patientsRepository => patientsRepository;
  List<Patient> get recentlyModifiedPatients {
    return _patientsRepository
        .query(
          Patient_.modifiedOn.lessOrEqualDate(DateTime.now()),
        )
        .build()
        .find()
        .take(5)
        .toList();
  }

  int get number => recentlyModifiedPatients.length;
}
