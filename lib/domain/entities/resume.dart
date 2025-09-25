class RequestResume {
  final String job_title;
  final String education;
  final String work_xp;
  final String skills;

  RequestResume({
    required this.job_title,
    required this.education,
    required this.work_xp,
    required this.skills,
  });
}

class RequestEmployerResume {
  final String? user_name;
  final String? phone;
  final String? photo;
  final String? organization_name;

  RequestEmployerResume({
    required this.user_name,
    required this.phone,
    required this.photo,
    required this.organization_name,
  });
}

class ResponseResume {
  final String education;
  final bool is_active;
  final String job_title;
  final int? resume_id;
  final String skills;
  final int? user_id;
  final String work_xp;

  ResponseResume({
    required this.education,
    this.is_active = false,
    required this.job_title,
    this.resume_id,
    required this.skills,
    this.user_id,
    required this.work_xp,
  });
}

class ResponseEmployerResume {
  final String? phone;
  final double rating;
  final int review_count;
  final String? tg_username;
  final String? user_name;
  final String? user_role;

  ResponseEmployerResume({
    this.phone,
    required this.rating,
    required this.review_count,
    this.tg_username,
    this.user_name,
    this.user_role,
  });

  factory ResponseEmployerResume.fromJson(Map<String, dynamic> json) {
    return ResponseEmployerResume(
      phone: json['phone']?.toString(), // Конвертируем в String если не null
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      review_count: (json['review_count'] as int?) ?? 0,
      tg_username: json['tg_username']?.toString(),
      user_name: json['user_name']?.toString(),
      user_role: json['user_role']?.toString(),
    );
  }
}


