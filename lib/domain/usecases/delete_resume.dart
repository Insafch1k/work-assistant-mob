import 'package:work_assistent_mob/domain/repositories/resume_repository.dart';

class DeleteResume {
  final ResumeRepository repository;

  DeleteResume({required this.repository});

  Future<void> execute() async {
    return await repository.deleteResume();
  }
}