import 'package:dermatosis/main.dart';
import 'package:dermatosis/navigation/navigation_bloc.dart';
import 'package:dermatosis/patients/patient.dart';
import 'package:dermatosis/patients/patients_repository.dart';
import 'package:forui/forui.dart';

import '../objectbox.g.dart';
import '../patients/patient_page.dart';

final searchRM = SearchBloc();

class SearchBloc {
  final searchRM = RM.injectTextEditing(text: '');

  TextEditingController get controller => searchRM.controller;
  List<Patient> get queriedPatients {
    return patientsRepository
        .query(
          Patient_.name.contains(searchRM.text),
        )
        .build()
        .find();
  }
}

class SearchPage extends UI {
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: FHeader(
        title: 'Search'.text(),
        suffixes: [
          FHeaderAction.back(
            onPress: navigator.back,
          ),
        ],
      ),
      child: Column(
        children: [
          FTextField(
            controller: searchRM.searchRM.controller,
          ).pad(),
          Expanded(
            child: searchRM.searchRM.text.isEmpty
                ? Center(child: 'Empty'.text())
                : ListView.builder(
                    itemCount: searchRM.queriedPatients.length,
                    itemBuilder: (context, index) {
                      final queriedPatient = searchRM.queriedPatients[index];
                      return FTile(
                        title: queriedPatient.name.text(),
                        subtitle: queriedPatient.complaints.text(),
                        onPress: () => navigator.to(
                          PatientPage(queriedPatient.id),
                        ),
                      ).pad();
                    },
                  ),
          )
        ],
      ),
    );
  }
}
