import 'package:work_assistent_mob/domain/repositories/advertisement_repository.dart';

class AddAdvertisementToFavorite {
  final AdvertisementRepository repository;

  const AddAdvertisementToFavorite(this.repository);

  Future<void> execute(int job_id) async {
    try {
      await repository.addAdvertisementToFavorite(job_id);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> call(int job_id) async => execute(job_id);
}
