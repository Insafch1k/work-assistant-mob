import 'package:work_assistent_mob/domain/entities/advertisement.dart';
import 'package:work_assistent_mob/domain/repositories/advertisement_repository.dart';

class GetFavoriteAdvertisements {
  final AdvertisementRepository repository;

  GetFavoriteAdvertisements(this.repository);

  Future<List<FavoriteAdvertisement>> call() async{
    return await repository.getFavoriteAdvertisements();
  }

}