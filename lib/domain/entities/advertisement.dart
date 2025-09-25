class ResponseAdvertisement {
  final String? address;
  final bool? car;
  final String? created_at;
  final int? employer_id;
  final bool? is_favorite;
  final bool? is_urgent;
  final int? job_id;
  final String? phone;
  final String? rating;
  final int? salary;
  final String? city;
  final String tg_username;
  final double? time_hours;
  final String? title;

  ResponseAdvertisement({
    required this.address,
    required this.car,
    required this.created_at,
    required this.employer_id,
    required this.is_favorite,
    required this.is_urgent,
    required this.job_id,
    required this.phone,
    required this.rating,
    required this.salary,
    required this.city,
    required this.tg_username,
    required this.time_hours,
    required this.title,
  });
}

class ResponseFilteredAdvertisement {
  final String? address;
  final bool? car;
  final String? created_at;
  final int? employer_id;
  final bool? is_favorite;
  final bool? is_urgent;
  final int? job_id;
  final String? phone;
  final String? rating;
  final int? salary;
  final String tg_username;
  final double? time_hours;
  final String? title;
  final String? city;

  ResponseFilteredAdvertisement({
    required this.address,
    required this.car,
    required this.created_at,
    required this.employer_id,
    required this.is_favorite,
    required this.is_urgent,
    required this.job_id,
    required this.phone,
    required this.rating,
    required this.salary,
    required this.tg_username,
    required this.time_hours,
    required this.title,
    required this.city
  });
}


class DetailedResponseAdvertisement{
  final String? address;
  final String? age;
  final bool? car;
  final String? date;
  final String? description;
  final double? hours;
  final bool? is_favorite;
  final bool? is_urgent;
  final String? phone;
  final int? salary;
  final String? time_end;
  final String? time_start;
  final String? title;
  final String? user_name;
  final String? wanted_job;
  final String? xp;

  DetailedResponseAdvertisement({
    required this.address,
    required this.age,
    required this.car,
    required this.date,
    required this.description,
    required this.hours,
    required this.is_favorite,
    required this.is_urgent,
    required this.phone,
    required this.salary,
    required this.time_end,
    required this.time_start,
    required this.title,
    required this.user_name,
    required this.wanted_job,
    required this.xp,
  });
}

class FavoriteAdvertisement {
  final String address;
  final int favorite_id;
  final bool is_favorite;
  final bool is_urgent;
  final int job_id;
  final String photo;
  final String rating;
  final int salary;
  final String time_hours;  
  final String title;

  FavoriteAdvertisement({
    required this.address,
    required this.favorite_id,
    required this.is_favorite,
    required this.is_urgent,
    required this.job_id,
    required this.photo,
    required this.rating,
    required this.salary,
    required this.time_hours,
    required this.title,
  });
}

class AdvertisementForAddFavorite {
  final String time;
  final int favorite_id;
  final int finder_id;
  final int job_id;

  AdvertisementForAddFavorite({
    required this.time,
    required this.favorite_id,
    required this.finder_id,
    required this.job_id,
  });

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'favorite_id': favorite_id,
      'finder_id': finder_id,
      'job_id': job_id
    };
  }
}


class RequestCreateAdvertisement {
  final String? title;
  final String? wanted_job;
  final String? description;
  final int? salary;
  final String? date;
  final String? time_start;
  final String? time_end;
  final String? address;
  final bool? is_urgent;
  final String? xp;
  final String? age;
  final bool? car;
  final String? city;

  RequestCreateAdvertisement({
    required this.title,
    required this.wanted_job,
    required this.description,
    required this.salary,
    required this.date,
    required this.time_start,
    required this.time_end,
    required this.address,
    required this.is_urgent,
    required this.xp,
    required this.age,
    required this.car,
    required this.city,
  });
}

class ResponseEmployerAdvertisement {
  final int? job_id;
  final int? employer_id;
  final String? title;
  final String? wanted_job;
  final String? description;
  final int? salary;
  final double? time_hours;
  final String? date;
  final String? time_start;
  final String? time_end;
  final String? address;
  final bool? is_urgent;
  final String? xp;
  final String? age;
  final bool? car;
  final String? city;
  final String? message;

  ResponseEmployerAdvertisement({
    required this.job_id,
    required this.employer_id,
    required this.title,
    required this.wanted_job,
    required this.description,
    required this.salary,
    required this.time_hours,
    required this.date,
    required this.time_start,
    required this.time_end,
    required this.address,
    required this.is_urgent,
    required this.xp,
    required this.age,
    required this.car,
    required this.city,
    required this.message
  });
}


