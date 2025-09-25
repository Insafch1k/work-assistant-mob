import 'package:work_assistent_mob/domain/entities/resume.dart';

class RequestResumeModel extends RequestResume {
  RequestResumeModel({
    required super.job_title,
    required super.education,
    required super.work_xp,
    required super.skills,
  });

  Map<String, dynamic> toJson() => {
    'job_title': job_title,
    'education': education,
    'work_xp': work_xp,
    'skills': skills,
  };
}

class RequestEmployerResumeModel extends RequestEmployerResume {
  RequestEmployerResumeModel({
    String? user_name, 
    String? phone, 
    String? photo, 
    String? organization_name, 
  }) : super(
         user_name: user_name,
         phone: phone,
         photo: photo,
         organization_name: organization_name,
       );

  @override
  Map<String, dynamic> toJson() => {
    'user_name': user_name ?? '',  
    'phone': phone ?? '',  
    'photo': photo ?? '', 
    'organization_name': organization_name ?? '',
  };
}

class ResponseResumeModel extends ResponseResume {
  ResponseResumeModel({
    required String education,
    bool is_active = false,
    required String job_title,
    int? resume_id,
    required String skills,
    int? user_id,
    required String work_xp,
  }) : super(
         education: education,
         is_active: is_active,
         job_title: job_title,
         resume_id: resume_id,
         skills: skills,
         user_id: user_id,
         work_xp: work_xp,
       );

  factory ResponseResumeModel.fromJson(Map<String, dynamic> json) {
    return ResponseResumeModel(
      education: json['education'] ?? '', 
      is_active: json['is_active'] ?? false,
      job_title: json['job_title'] ?? '',
      resume_id: json['resume_id'],
      skills: json['skills'] ?? '',
      user_id: json['user_id'],
      work_xp: json['work_xp'] ?? '',
    );
  }
}

class ResponseEmployerResumeModel extends ResponseEmployerResume {
  ResponseEmployerResumeModel({
    String? phone, 
    double? rating, 
    int? review_count, 
    String? tg_username, 
    String? user_name, 
    String? user_role, 
  }) : super(
         phone: phone,
         rating: rating ?? 0.0, 
         review_count: review_count ?? 0, 
         tg_username: tg_username,
         user_name: user_name,
         user_role: user_role,
       );

  factory ResponseEmployerResumeModel.fromJson(Map<String, dynamic> json) {
    try {
      return ResponseEmployerResumeModel(
        phone: json['phone']?.toString(),
        rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
        review_count: (json['review_count'] as int?) ?? 0,
        tg_username: json['tg_username']?.toString(),
        user_name: json['user_name']?.toString(),
        user_role: json['user_role']?.toString(),
      );
    } catch (e) {
      print('Ошибка парсинга резюме работодателя: $e');
      throw Exception('Ошибка парсинга резюме работодателя: ${e.toString()}');
    }
  }
}
