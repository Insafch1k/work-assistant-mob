import 'package:work_assistent_mob/domain/entities/advertisement.dart';
import 'package:work_assistent_mob/domain/repositories/advertisement_repository.dart';

class GetDetailedAdvertisement {
  final AdvertisementRepository repository;

  GetDetailedAdvertisement(this.repository);

  Future<DetailedResponseAdvertisement> call(int job_id) async{
    return await repository.getDetailedAdvertisement(job_id);
  }
}