import 'package:dermatosis/imageries/imageries_repository.dart';
import 'package:file_picker/file_picker.dart';

import '../main.dart';
import 'imageries.dart';

final imageriesBloc = ImageriesBloc();

class ImageriesBloc {
  final imageriesRM = RM.inject(() => imageriesRepository.getAll());

  bool get loading => imageriesRM.isWaiting;
  List<Imagery> get imageries => imageriesRM.state;

  void put(Imagery imagery) {
    imageriesRepository.put(imagery);
    imageriesRM.stateAsync = imageriesRepository.getAllAsync();
  }

  void remove(int id) {
    imageriesRepository.remove(id);
    imageriesRM.stateAsync = imageriesRepository.getAllAsync();
  }

  Future<void> pickAndSave() async {
    final pickerResult = await FilePicker.platform.pickFiles();
    if (pickerResult != null) {
      final pickedPath = pickerResult.files.first.path;

      if (pickedPath != null) {
        put(Imagery()..path = pickedPath);
      }
    }
    return null;
  }
}
