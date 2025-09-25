import 'package:work_assistent_mob/domain/entities/resume.dart';
import 'package:work_assistent_mob/domain/repositories/resume_repository.dart';

class SendResume {
  final ResumeRepository repository;

  SendResume({required this.repository});

  Future<ResponseResume> execute(RequestResume request) async {
    return await repository.sendResume(request);
  }
}