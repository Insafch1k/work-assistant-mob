import 'package:work_assistent_mob/domain/entities/advertisement.dart';
import 'package:work_assistent_mob/domain/repositories/advertisement_repository.dart';

class ReductAdvertisement {
  final AdvertisementRepository repository;

  ReductAdvertisement({required this.repository});

  Future<String> execute(RequestCreateAdvertisement request, int job_id) async {
    return await repository.reductAdvertisement(request, job_id);
  }
}