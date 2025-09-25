import 'package:work_assistent_mob/domain/entities/advertisement.dart';

class ResponseAdvertisementModel extends ResponseAdvertisement {
  ResponseAdvertisementModel({
    required super.address,
    required super.car,
    required super.created_at,
    required super.employer_id,
    required super.is_favorite,
    required super.is_urgent,
    required super.job_id,
    required super.phone,
    required super.rating,
    required super.salary,
    required super.city,
    required super.tg_username,
    required super.time_hours,
    required super.title,
  });

  factory ResponseAdvertisementModel.fromJson(Map<String, dynamic> json) {
    return ResponseAdvertisementModel(
      address: json['address'] as String? ?? 'Не указан',
      car: json['car'] as bool? ?? false,
      created_at: json['created_at'] as String? ?? '',
      employer_id: json['employer_id'] as int? ?? 0,
      is_favorite: json['is_favorite'] as bool? ?? false,
      is_urgent: json['is_urgent'] as bool? ?? false,
      job_id: json['job_id'] as int? ?? 0,
      phone: json['phone'] as String? ?? '',
      rating: json['rating'] as String? ?? '0',
      salary: json['salary'] as int? ?? 0,
      city: json['city'] as String? ?? '',
      tg_username: json['tg_username'] as String? ?? "",
      time_hours: json['time_hours'] as double? ?? 0.0,
      title: json['title'] as String? ?? 'Без названия',
    );
  }

  ResponseAdvertisement toEntity() {
    return ResponseAdvertisement(
      address: address,
      car: car,
      created_at: created_at,
      employer_id: employer_id,
      is_favorite: is_favorite,
      is_urgent: is_urgent,
      job_id: job_id,
      phone: phone,
      rating: rating,
      salary: salary,
      city: city,
      tg_username: tg_username,
      time_hours: time_hours,
      title: title,
    );
  }
}

class ResponseFilteredAdvertisementModel extends ResponseFilteredAdvertisement {
  ResponseFilteredAdvertisementModel({
    required super.address,
    required super.car,
    required super.created_at,
    required super.employer_id,
    required super.is_favorite,
    required super.is_urgent,
    required super.job_id,
    required super.phone,
    required super.rating,
    required super.salary,
    required super.tg_username,
    required super.time_hours,
    required super.title,
    required super.city
  });

  factory ResponseFilteredAdvertisementModel.fromJson(Map<String, dynamic> json) {
    return ResponseFilteredAdvertisementModel(
      address: json['address'] as String? ?? 'Не указан',
      car: json['car'] as bool? ?? false,
      created_at: json['created_at'] as String? ?? '',
      employer_id: json['employer_id'] as int? ?? 0,
      is_favorite: json['is_favorite'] as bool? ?? false,
      is_urgent: json['is_urgent'] as bool? ?? false,
      job_id: json['job_id'] as int? ?? 0,
      phone: json['phone'] as String? ?? '',
      rating: json['rating'] as String? ?? '0',
      salary: json['salary'] as int? ?? 0,
      tg_username: json['tg_username'] as String? ?? "",
      time_hours: json['time_hours'] as double? ?? 0.0,
      title: json['title'] as String? ?? 'Без названия',
      city: json['city'] as String? ?? ''
    );
  }

  ResponseFilteredAdvertisement toEntity() {
    return ResponseFilteredAdvertisement(
      address: address,
      car: car,
      created_at: created_at,
      employer_id: employer_id,
      is_favorite: is_favorite,
      is_urgent: is_urgent,
      job_id: job_id,
      phone: phone,
      rating: rating,
      salary: salary,
      tg_username: tg_username,
      time_hours: time_hours,
      title: title,
      city: city
    );
  }
}

class DetailedResponseAdvertisementModel extends DetailedResponseAdvertisement {
  DetailedResponseAdvertisementModel({
    required super.address,
    required super.age,
    required super.car,
    required super.date,
    required super.description,
    required super.hours,
    required super.is_favorite,
    required super.is_urgent,
    required super.phone,
    required super.salary,
    required super.time_end,
    required super.time_start,
    required super.title,
    required super.user_name,
    required super.wanted_job,
    required super.xp,
  });

  factory DetailedResponseAdvertisementModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return DetailedResponseAdvertisementModel(
      address: json['address'] as String? ?? 'Не указан',
      age: json['age'] as String? ?? '',
      car: json['car'] as bool? ?? false,
      date: json['date'] as String? ?? '',
      description: json['description'] as String? ?? '',
      hours: (json['hours'] as num?)?.toDouble() ?? 0.0,
      is_favorite: json['is_favorite'] as bool? ?? false,
      is_urgent: json['is_urgent'] as bool? ?? false,
      phone: json['phone'] as String? ?? '',
      salary: json['salary'] as int? ?? 0,
      time_end: json['time_end'] as String? ?? '',
      time_start: json['time_start'] as String? ?? '',
      title: json['title'] as String? ?? 'Без названия',
      user_name: json['user_name'] as String? ?? '',
      wanted_job: json['wanted_job'] as String? ?? '',
      xp: json['xp'] as String? ?? '',
    );
  }

  DetailedResponseAdvertisement toEntity() {
    return DetailedResponseAdvertisement(
      address: address,
      age: age,
      car: car,
      date: date,
      description: description,
      hours: hours,
      is_favorite: is_favorite,
      is_urgent: is_urgent,
      phone: phone,
      salary: salary,
      time_end: time_end,
      time_start: time_start,
      title: title,
      user_name: user_name,
      wanted_job: wanted_job,
      xp: xp,
    );
  }
}

class FavoriteAdvertisementModel extends FavoriteAdvertisement {
  FavoriteAdvertisementModel({
    required super.address,
    required super.favorite_id,
    required super.is_favorite,
    required super.is_urgent,
    required super.job_id,
    required super.photo,
    required super.rating,
    required super.salary,
    required super.time_hours,
    required super.title,
  });

  ResponseAdvertisement toResponseAdvertisement() {
    return ResponseAdvertisement(
      address: address,
      car: false,
      created_at: '',
      employer_id: 0,
      is_favorite: is_favorite,
      is_urgent: is_urgent,
      job_id: job_id,
      phone: '',
      rating: rating,
      salary: salary,
      city: '',
      tg_username: '',
      time_hours: double.tryParse(time_hours) ?? 0.0,
      title: title,
    );
  }

  factory FavoriteAdvertisementModel.fromJson(Map<String, dynamic> json) {
    return FavoriteAdvertisementModel(
      address: json['address'] as String? ?? '',
      favorite_id: json['favorite_id'] as int,
      is_favorite: json['is_favorite'] as bool,
      is_urgent: json['is_urgent'] as bool,
      job_id: json['job_id'] as int,
      photo: json['photo'] as String? ?? '',
      rating: json['rating'] as String,
      salary: json['salary'] as int? ?? 0,
      time_hours: (json['time_hours']?.toString() ?? '0'),
      title: json['title'] as String,
    );
  }

  FavoriteAdvertisement toEntity() {
    return FavoriteAdvertisement(
      address: address,
      favorite_id: favorite_id,
      is_favorite: is_favorite,
      is_urgent: is_urgent,
      job_id: job_id,
      photo: photo,
      rating: rating,
      salary: salary,
      time_hours: time_hours,
      title: title,
    );
  }
}

class AdvertisementForAddFavoriteModel {
  final String time;
  final int favorite_id;
  final int finder_id;
  final int job_id;

  AdvertisementForAddFavoriteModel({
    required this.time,
    required this.favorite_id,
    required this.finder_id,
    required this.job_id,
  });

  factory AdvertisementForAddFavoriteModel.fromJson(Map<String, dynamic> json) {
    return AdvertisementForAddFavoriteModel(
      time: json['time'] as String,
      favorite_id: json['favorite_id'] as int,
      finder_id: json['finder_id'] as int,
      job_id: json['job_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'favorite_id': favorite_id,
      'finder_id': finder_id,
      'job_id': job_id,
    };
  }

  AdvertisementForAddFavoriteModel toEntity() {
    return AdvertisementForAddFavoriteModel(
      time: time,
      favorite_id: favorite_id,
      finder_id: finder_id,
      job_id: job_id,
    );
  }
}

class RequestCreateAdvertisementModel extends RequestCreateAdvertisement {
  RequestCreateAdvertisementModel({
    String? title,
    String? wanted_job,
    String? description,
    int? salary,
    String? date,
    String? time_start,
    String? time_end,
    String? address,
    bool? is_urgent,
    String? xp,
    String? age,
    bool? car,
    String? city,
  }) : super(
         title: title,
         wanted_job: wanted_job,
         description: description,
         salary: salary,
         date: date,
         time_start: time_start,
         time_end: time_end,
         address: address,
         is_urgent: is_urgent,
         xp: xp,
         age: age,
         car: car,
         city: city,
       );

  @override
  Map<String, dynamic> toJson() => {
    'title': title ?? '',
    'wanted_job': wanted_job ?? '',
    'description': description ?? '',
    'salary': salary ?? 0,
    'date': date ?? '',
    'time_start': time_start ?? '',
    'time_end': time_end ?? '',
    'address': address ?? '',
    'is_urgent': is_urgent ?? false,
    'xp': xp ?? '',
    'age': age ?? '',
    'car': car ?? false,
    'city': city ?? '',
  };
}

class ResponseEmployerAdvertisementModel extends ResponseEmployerAdvertisement {
  ResponseEmployerAdvertisementModel({
    int? job_id,
    int? employer_id,
    String? title,
    String? wanted_job,
    String? description,
    int? salary,
    double? time_hours,
    String? date,
    String? time_start,
    String? time_end,
    String? address,
    bool? is_urgent,
    String? xp,
    String? age,
    bool? car,
    String? city,
    String? message,
  }) : super(
         job_id: job_id,
         employer_id: employer_id,
         title: title,
         wanted_job: wanted_job,
         description: description,
         salary: salary,
         time_hours: time_hours,
         date: date,
         time_start: time_start,
         time_end: time_end,
         address: address,
         is_urgent: is_urgent,
         xp: xp,
         age: age,
         car: car,
         city: city,
         message: message,
       );

  factory ResponseEmployerAdvertisementModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ResponseEmployerAdvertisementModel(
      address: json['address'] as String? ?? '',
      car: json['car'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      employer_id: json['employer_id'] as int? ?? 0,
      xp: json['xp'] as String? ?? '',
      is_urgent: json['is_urgent'] as bool? ?? false,
      job_id: json['job_id'] as int? ?? 0,
      wanted_job: json['wanted_job'] as String? ?? '',
      time_end: json['time_end'] as String? ?? '',
      salary: json['salary'] as int? ?? 0,
      time_hours: json['time_hours'] as double ?? 0.0,
      time_start: json['time_start'] as String? ?? '',
      city: json['city'] as String? ?? '',
      title: json['title'] as String? ?? '',
    );
  }

  ResponseEmployerAdvertisement toEntity() {
    return ResponseEmployerAdvertisement(
      address: address,
      car: car,
      message: message,
      employer_id: employer_id,
      time_end: time_end,
      time_start: time_end,
      job_id: job_id,
      city: city,
      wanted_job: wanted_job,
      salary: salary,
      time_hours: time_hours,
      xp: xp,
      is_urgent: is_urgent,
      title: title,
      description: description,
      date: date,
      age: age,
    );
  }
}
