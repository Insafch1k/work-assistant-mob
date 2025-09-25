import 'package:work_assistent_mob/data/models/resume_model.dart';
import 'package:work_assistent_mob/domain/entities/resume.dart';
import 'package:work_assistent_mob/domain/repositories/resume_repository.dart';

class GetEmployerResumes {
  final ResumeRepository repository;

  GetEmployerResumes({required this.repository});

  Future<List<ResponseEmployerResume>> call() async {
    try {
      final dynamic response = await repository.getEmployerResumes();

      if (response == null) {
        throw Exception('Ответ null');
      }

      if (response is List<ResponseEmployerResume>) {
        return response;
      }

      if (response is List<dynamic>) {
        return response.map<ResponseEmployerResume>((dynamic item) {
          if (item is ResponseEmployerResume) {
            return item;
          } else if (item is Map<String, dynamic>) {
            return ResponseEmployerResumeModel.fromJson(item);
          }
          throw Exception('Неправльное поле в списке: ${item.runtimeType}');
        }).toList();
      }

      // Обработка одиночного Map
      if (response is Map<String, dynamic>) {
        return [ResponseEmployerResumeModel.fromJson(response)];
      }

      throw Exception('Неподдерживаемый тип ответа: ${response.runtimeType}');
    } catch (e) {
      print('Ошибка в получении резюме работодателя: $e');
      rethrow;
    }
  }
}