import 'package:work_assistent_mob/domain/entities/advertisement.dart';
import 'package:work_assistent_mob/domain/repositories/advertisement_repository.dart';

class GetEmployerAdvertisements {
  final AdvertisementRepository repository;

  GetEmployerAdvertisements(this.repository);

  Future<List<ResponseEmployerAdvertisement>> call() async{
    return await repository.getEmployersAdvertisements();
  }

}