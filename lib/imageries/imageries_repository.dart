import 'package:dermatosis/imageries/imageries.dart';
import 'package:dermatosis/main.dart';

class ImageriesRepository {
  final _imageries = store.box<Imagery>();
  late final getAll = _imageries.getAll;
  late final get = _imageries.get;
  late final put = _imageries.put;
  late final remove = _imageries.remove;
  late final removeAll = _imageries.removeAll;
  late final getAllAsync = _imageries.getAllAsync;
}

final imageriesRepository = ImageriesRepository();
