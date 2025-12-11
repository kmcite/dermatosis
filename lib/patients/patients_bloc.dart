import 'package:dermatosis/main.dart';
import 'package:dermatosis/patients/patient.dart';
import 'package:dermatosis/patients/patients_repository.dart';

final patientsBloc = PatientsBloc();

class PatientsBloc {
  late final patientsRM = RM.injectStream(
    () => patientsRepository.watch(),
    initialState: patientsRepository.getAll(),
  );
  List<Patient> get patients => patientsRM.state;
  void put(Patient patient) {
    // this modifiedOn is used in recently modified feature
    patientsRepository.put(patient..modifiedOn = DateTime.now());

    patientsRM.stateAsync = patientsRepository.getAllAsync();
  }

  void remove(int id) {
    patientsRepository.remove(id);
    patientsRM.stateAsync = patientsRepository.getAllAsync();
  }

  void removeAll() {
    patientsRepository.removeAll();
    patientsRM.stateAsync = patientsRepository.getAllAsync();
  }

  Patient get(int id) => patients.firstWhere((patient) => patient.id == id);
}
