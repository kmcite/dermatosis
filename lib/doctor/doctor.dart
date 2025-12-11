import 'package:dermatosis/main.dart';
import 'package:dermatosis/objectbox.g.dart';
import 'package:dermatosis/patients/patients_repository.dart';

@Entity()
class Doctor {
  @Id()
  int id = 0;
  String name = '';
  String description = '';
  String email = 'adn@gmail.com';
}

class DoctorsRepository with CRUD<Doctor> {
  Doctor? search(String email) {
    return getAll().where((doctor) => doctor.email == email).firstOrNull;
  }
}

final doctorsRepository = DoctorsRepository();
final doctorsRM = DoctorsBloc();

class DoctorsBloc {
  final doctorsRM = RM.injectStream(
    () => doctorsRepository.watch(),
    initialState: doctorsRepository.getAll(),
  );

  Doctor? get(int? id) {
    return doctors.where(
      (doctor) {
        return doctor.id == id;
      },
    ).firstOrNull;
  }

  List<Doctor> get doctors => doctorsRM.state;
}
