// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dermatosis/main.dart';
import 'package:dermatosis/patients/patient.dart';

PatientsRepository get patientsRepository => patientRepositoryRM.state;
final patientRepositoryRM = RM.inject(() => PatientsRepository());

class PatientsRepository with CRUD<Patient> {
  Patient? search(String email) =>
      getAll().where((patient) => patient.email == email).firstOrNull;
}
