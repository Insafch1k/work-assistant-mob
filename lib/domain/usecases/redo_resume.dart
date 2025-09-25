import 'package:work_assistent_mob/domain/entities/resume.dart';
import 'package:work_assistent_mob/domain/repositories/resume_repository.dart';

class RedoResume {
  final ResumeRepository repository;

  RedoResume({required this.repository});

  Future<ResponseResume> execute(RequestResume request) async {
    return await repository.redoResume(request);
  }
}