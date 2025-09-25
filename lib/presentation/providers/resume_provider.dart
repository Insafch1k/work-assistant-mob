import 'package:flutter/material.dart';
import 'package:work_assistent_mob/data/models/resume_model.dart';
import 'package:work_assistent_mob/domain/entities/resume.dart';
import 'package:work_assistent_mob/domain/usecases/delete_resume.dart';
import 'package:work_assistent_mob/domain/usecases/get_employer_resume.dart';
import 'package:work_assistent_mob/domain/usecases/get_resumes.dart';
import 'package:work_assistent_mob/domain/usecases/redo_employer_resume.dart';
import 'package:work_assistent_mob/domain/usecases/redo_resume.dart';
import 'package:work_assistent_mob/domain/usecases/send_resume.dart';

class ResumeProvider with ChangeNotifier {
  final SendResume sendResumeUseCase;
  final RedoResume redoResumeUseCase;
  final RedoEmployerResume redoEmployerResumeUseCase;
  final GetResumes getResumesUseCase;
  final GetEmployerResumes getEmployerResumesUseCase;
  final DeleteResume deleteResumeUseCase;

  bool _hasResume = false;
  bool _employerHasResume = false;
  List<ResponseResume> _resumes = [];
  List<ResponseEmployerResume> _employerResumes = [];
  ResponseEmployerResume? _currentEmployerResume;
  ResponseResume? _currentResume;

  bool get hasResume => _hasResume;
  bool get employerHasResume => _employerHasResume;
  List<ResponseResume> get resumes => _resumes;
  List<ResponseEmployerResume> get employerResumes => _employerResumes;
  ResponseResume? get currentResume => _currentResume;
  ResponseEmployerResume? get currentEmployerResume => _currentEmployerResume;

  ResumeProvider({
    required this.sendResumeUseCase,
    required this.getResumesUseCase,
    required this.getEmployerResumesUseCase,
    required this.redoResumeUseCase,
    required this.redoEmployerResumeUseCase,
    required this.deleteResumeUseCase,
  });

  Future<void> sendResume({
    required String jobTitle,
    required String education,
    required String workXp,
    required String skills,
  }) async {
    notifyListeners();

    try {
      _currentResume = await sendResumeUseCase.execute(
        RequestResume(
          job_title: jobTitle,
          education: education,
          work_xp: workXp,
          skills: skills,
        ),
      );
      _hasResume = true;
    } catch (e) {
      _hasResume = false;
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<void> redoResume({
    required String jobTitle,
    required String education,
    required String workXp,
    required String skills,
  }) async {
    notifyListeners();

    try {
      _currentResume = await redoResumeUseCase.execute(
        RequestResume(
          job_title: jobTitle,
          education: education,
          work_xp: workXp,
          skills: skills,
        ),
      );
    } catch (e) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<void> redoEmployerResume({
    String? user_name,
    String? phone,
    String? photo,
    String? organization_name,
  }) async {
    try {
      await redoEmployerResumeUseCase.execute(
        RequestEmployerResumeModel(
          user_name: user_name,
          phone: phone,
          photo: photo,
          organization_name: organization_name,
        ),
      );
      notifyListeners();
    } catch (e) {
      print('Error updating employer resume: $e');
      rethrow;
    }
  }

  Future<void> fetchResumes() async {
    try {
      _resumes = await getResumesUseCase();
      _hasResume = _resumes.isNotEmpty;

      if (_hasResume) {
        _currentResume = _resumes.first;
      } else {
        _currentResume = null;
      }
      notifyListeners(); 
    } catch (e) {
      print('Error fetching resumes: $e');
      _resumes = [];
      _hasResume = false;
      _currentResume = null;
      notifyListeners();
    }
  }

  Future<void> fetchEmployerResumes() async {
  try {
    final List<ResponseEmployerResume> response = await getEmployerResumesUseCase.call();
    
    final List<ResponseEmployerResume> resumes = response.whereType<ResponseEmployerResume>().toList();

    _employerResumes = resumes;
    _employerHasResume = resumes.isNotEmpty;
    _currentEmployerResume = _employerHasResume ? resumes.first : null;

    await fetchEmployerResumes();
    
    notifyListeners();
  } catch (e) {
    print('Ошибка в поиске резюме раотодателя: $e');
    _employerResumes = [];
    _employerHasResume = false;
    _currentEmployerResume = null;
    notifyListeners();
    throw Exception('Ошибка в загрузке резюме работодателя: ${e.toString()}');
  }
}

  Future<void> deleteResume() async {
    notifyListeners();

    try {
      await deleteResumeUseCase.execute();

      _resumes.clear();
      _currentResume = null;
      _hasResume = false;
    } catch (e) {
      print('Ошибка в провайдере при удалении резюме: $e');
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  void clearResumes() {
    _resumes = [];
    _currentResume = null;
    _hasResume = false;
    notifyListeners();
  }
}
