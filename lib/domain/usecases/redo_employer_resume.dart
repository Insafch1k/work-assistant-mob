import 'package:work_assistent_mob/domain/entities/resume.dart';
import 'package:work_assistent_mob/domain/repositories/resume_repository.dart';

class RedoEmployerResume {
  final ResumeRepository repository;

  RedoEmployerResume({required this.repository});

  Future<void> execute(RequestEmployerResume request) async {
    return await repository.redoEmployerResume(request);
  }
}