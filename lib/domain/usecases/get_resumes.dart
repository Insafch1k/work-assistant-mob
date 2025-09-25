import 'package:work_assistent_mob/domain/entities/resume.dart';
import 'package:work_assistent_mob/domain/repositories/resume_repository.dart';

class GetResumes {
  final ResumeRepository repository;

  GetResumes({required this.repository});

  Future<List<ResponseResume>> call() async {
    return await repository.getResumes();
  }
}
