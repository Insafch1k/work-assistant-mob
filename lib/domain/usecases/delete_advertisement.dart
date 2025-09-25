import 'package:work_assistent_mob/domain/repositories/advertisement_repository.dart';

class DeleteAdvertisement {
  final AdvertisementRepository repository;

  const DeleteAdvertisement({required this.repository});

  Future<String> call(int job_id) async {
    return await repository.deleteAdvertisement(job_id);
  }
}
