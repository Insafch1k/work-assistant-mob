import 'package:work_assistent_mob/domain/entities/advertisement.dart';
import 'package:work_assistent_mob/domain/repositories/advertisement_repository.dart';

class GetAdvertisementsFromHistory {
  final AdvertisementRepository repository;

  GetAdvertisementsFromHistory(this.repository);

  Future<List<ResponseAdvertisement>> call() async{
    return await repository.getAdvertisementsFromHistory();
  }

}