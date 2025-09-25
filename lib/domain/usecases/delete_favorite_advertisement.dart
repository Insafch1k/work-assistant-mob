import 'package:work_assistent_mob/domain/repositories/advertisement_repository.dart';

class DeleteAdvertisementFromFavorite {
  final AdvertisementRepository repository;

  const DeleteAdvertisementFromFavorite(this.repository);

  Future<void> execute(int job_id) async {
    try {
      await repository.deleteAdvertisementFromFavorite(job_id);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> call(int job_id) async => execute(job_id);
}
