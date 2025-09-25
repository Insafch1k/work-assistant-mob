import 'package:work_assistent_mob/domain/entities/view.dart';

class ViewModel {
  final int finder_id;
  final int history_id;
  final int job_id;
  final String viewed_at;

  ViewModel({
    required this.finder_id,
    required this.history_id,
    required this.job_id,
    required this.viewed_at,
  });

  factory ViewModel.fromJson(Map<String, dynamic> json) {
    return ViewModel(
      finder_id: json['finder_id'] as int,
      history_id: json['history_id'] as int,
      job_id: json['job_id'] as int,
      viewed_at: json['viewed_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'finder_id': finder_id,
      'history_id': history_id,
      'job_id': job_id,
      'viewed_at': viewed_at,
    };
  }

 ViewEntity toEntity() {
    return ViewEntity(
      finder_id: finder_id,
      history_id: history_id,
      job_id: job_id,
      viewed_at: viewed_at,
    );
  }

  
}