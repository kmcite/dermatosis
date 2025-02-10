import 'package:dermatosis/main.dart';
import 'package:dermatosis/patients/patient.dart';
import 'package:dermatosis/patients/patients_repository.dart';

final patientsBloc = PatientsBloc();

class PatientsBloc {
  PatientsRepository get _patientsRepository => patientsRepository;

  late final patientsRM = RM.injectStream(
    () => _patientsRepository.watch(),
    initialState: _patientsRepository.getAll(),
  );
  List<Patient> get patients => patientsRM.state;
  void put(Patient patient) {
    // this modifiedOn is used in recently modified feature
    _patientsRepository.put(patient..modifiedOn = DateTime.now());

    patientsRM.stateAsync = _patientsRepository.getAllAsync();
  }

  void remove(int id) {
    _patientsRepository.remove(id);
    patientsRM.stateAsync = _patientsRepository.getAllAsync();
  }

  void removeAll() {
    _patientsRepository.removeAll();
    patientsRM.stateAsync = _patientsRepository.getAllAsync();
  }

  Patient get(int id) => patients.firstWhere((patient) => patient.id == id);
}
