import 'package:work_assistent_mob/domain/entities/resume.dart';

abstract class ResumeRepository {
  Future<ResponseResume> sendResume(RequestResume request);
  Future<ResponseResume> redoResume(RequestResume request);
  Future<void> redoEmployerResume(RequestEmployerResume request);
  Future<List<ResponseResume>> getResumes();
  Future<List<ResponseEmployerResume>> getEmployerResumes();
  Future<void> deleteResume();
}