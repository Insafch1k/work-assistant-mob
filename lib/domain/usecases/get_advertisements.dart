import 'package:work_assistent_mob/domain/entities/advertisement.dart';
import 'package:work_assistent_mob/domain/repositories/advertisement_repository.dart';

class GetAdvertisements {
  final AdvertisementRepository repository;

  GetAdvertisements(this.repository);

  Future<List<ResponseAdvertisement>> call() async{
    return await repository.getAdvertisements();
  }

}