import 'package:work_assistent_mob/domain/entities/advertisement.dart';
import 'package:work_assistent_mob/domain/repositories/advertisement_repository.dart';

class CreateAdvertisement {
  final AdvertisementRepository repository;

  CreateAdvertisement({required this.repository});

  Future<String> execute(RequestCreateAdvertisement request) async {
    return await repository.createAdvertisement(request);
  }
}