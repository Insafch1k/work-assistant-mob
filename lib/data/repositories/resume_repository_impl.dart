import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:work_assistent_mob/data/datasources/remote/resume_remote_data_source.dart';
import 'package:work_assistent_mob/data/models/resume_model.dart';
import 'package:work_assistent_mob/domain/entities/resume.dart';
import 'package:work_assistent_mob/domain/repositories/resume_repository.dart';

class ResumeRepositoryImpl implements ResumeRepository {
  final ResumeRemoteDataSource remoteDataSource;

  ResumeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ResponseResume> sendResume(RequestResume request) async {
    try {
      final requestModel = RequestResumeModel(
        job_title: request.job_title,
        education: request.education,
        work_xp: request.work_xp,
        skills: request.skills,
      );

      final response = await remoteDataSource.sendResume(requestModel);
      return response;
    } on http.ClientException catch (e) {
      throw Exception('Ошибка соединения: $e');
    } on SocketException catch (e) {
      throw Exception('Нет интернет-соединения: $e');
    } on FormatException catch (e) {
      throw Exception('Ошибка формата данных: $e');
    } catch (e) {
      throw Exception('Неизвестная ошибка: $e');
    }
  }

  @override
  Future<ResponseResume> redoResume(RequestResume request) async {
    try {
      final requestModel = RequestResumeModel(
        job_title: request.job_title,
        education: request.education,
        work_xp: request.work_xp,
        skills: request.skills,
      );

      final response = await remoteDataSource.redoResume(requestModel);
      return response;
    } on http.ClientException catch (e) {
      throw Exception('Ошибка соединения: $e');
    } on SocketException catch (e) {
      throw Exception('Нет интернет-соединения: $e');
    } on FormatException catch (e) {
      throw Exception('Ошибка формата данных: $e');
    } catch (e) {
      throw Exception('Неизвестная ошибка: $e');
    }
  }

  @override
  Future<void> redoEmployerResume(RequestEmployerResume request) async {
    try {
      final requestModel = RequestEmployerResumeModel(
        user_name: request.user_name,
        phone: request.phone,
        photo: request.photo,
        organization_name: request.organization_name,
      );

      final response = await remoteDataSource.redoEmployerResume(requestModel);
      return response;
    } on http.ClientException catch (e) {
      throw Exception('Ошибка соединения: $e');
    } on SocketException catch (e) {
      throw Exception('Нет интернет-соединения: $e');
    } on FormatException catch (e) {
      throw Exception('Ошибка формата данных: $e');
    } catch (e) {
      throw Exception('Неизвестная ошибка: $e');
    }
  }

  @override
  Future<List<ResponseResume>> getResumes() async {
    try {
      final resumes = await remoteDataSource.getResumes();
      return resumes;
    } on http.ClientException catch (e) {
      throw Exception('Ошибка соединения: $e');
    } on SocketException catch (e) {
      throw Exception('Нет интернет-соединения: $e');
    } on FormatException catch (e) {
      throw Exception('Ошибка формата данных: $e');
    } catch (e) {
      throw Exception('Неизвестная ошибка: $e');
    }
  }

  @override
  Future<List<ResponseEmployerResume>> getEmployerResumes() async {
    try {
      final response = await remoteDataSource.getEmployerResumes();

      if (response is List) {
        return response.map((item) {
          if (item is ResponseEmployerResume) {
            return item;
          }
          throw Exception('Неправильно в списке');
        }).toList();
      }

      throw Exception('Ошибка в ответе ${response.runtimeType}');
    } catch (e) {
      print('Ошибка в репозитории: $e');
      rethrow;
    }
  }

  @override
  Future<void> deleteResume() async {
    try {
      await remoteDataSource.deleteResume();
    } catch (e) {
      print('Ошибка удаления резюме: $e');
      rethrow;
    }
  }
}
