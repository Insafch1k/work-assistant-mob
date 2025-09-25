import 'package:flutter/foundation.dart';
import 'package:work_assistent_mob/domain/entities/view.dart';
import 'package:work_assistent_mob/domain/usecases/create_view.dart';

class ViewProvider with ChangeNotifier {
  final CreateView createViewUseCase;
  List<ViewEntity> _views = [];

  ViewProvider({required this.createViewUseCase});

  List<ViewEntity> get views => _views;

  Future<void> createNewView(int job_id) async {
    try {
      notifyListeners();
      final newView = await createViewUseCase(job_id);
      _views.add(newView);
    } catch (e) {
      print('Ошибка создания истории просмотра: $e');
      rethrow;
    } finally {
      notifyListeners();
    }
  }
}