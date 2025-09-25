class ViewEntity {
  final int finder_id;
  final int history_id;
  final int job_id;
  final String viewed_at;

  ViewEntity({
    required this.finder_id,
    required this.history_id,
    required this.job_id,
    required this.viewed_at,
  });

  Map<String, dynamic> toJson() {
    return {
      'finder_id': finder_id,
      'history_id': history_id,
      'job_id': job_id,
      'created_at': viewed_at
    };
  }

}
