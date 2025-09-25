import 'package:work_assistent_mob/domain/entities/advertisement.dart';
import 'package:work_assistent_mob/domain/repositories/advertisement_repository.dart';

class GetFilteredAdvertisements {
  final AdvertisementRepository repository;

  GetFilteredAdvertisements(this.repository);

  Future<List<ResponseFilteredAdvertisement>> call(String city) async{
    return await repository.getFilteredAdvertisements(city);
  }

}