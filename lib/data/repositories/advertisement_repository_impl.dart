import 'package:work_assistent_mob/data/datasources/remote/advertisement_remote_data_source.dart';
import 'package:work_assistent_mob/data/models/advertisement_model.dart';
import 'package:work_assistent_mob/domain/entities/advertisement.dart';
import 'package:work_assistent_mob/domain/repositories/advertisement_repository.dart';

class AdvertisementRepositoryImpl implements AdvertisementRepository {
  final AdvertisementRemoteDataSource remoteDataSource;

  AdvertisementRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ResponseAdvertisement>> getAdvertisements() async {
    final models = await remoteDataSource.getAdvertisements();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<ResponseFilteredAdvertisement>> getFilteredAdvertisements(String city) async {
    final models = await remoteDataSource.getFilteredAdvertisements(city);
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<ResponseEmployerAdvertisement>> getEmployersAdvertisements() async {
    final models = await remoteDataSource.getEmployersAdvertisements();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<DetailedResponseAdvertisement> getDetailedAdvertisement(
    int job_id,
  ) async {
    final model = await remoteDataSource.getDetailedAdvertisement(job_id);
    return model.toEntity();
  }

  @override
  Future<List<ResponseAdvertisement>> getAdvertisementsFromHistory() async {
    final models = await remoteDataSource.getAdvertisementsFromHistory();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<FavoriteAdvertisement>> getFavoriteAdvertisements() async {
    final models = await remoteDataSource.getFavoriteAdvertisements();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> addAdvertisementToFavorite(int job_id) async {
    await remoteDataSource.addAdvertisementToFavorite(job_id);
  }

  @override
  Future<void> deleteAdvertisementFromFavorite(int job_id) async {
    await remoteDataSource.deleteAdvertisementFromFavorite(job_id);
  }

  @override
  Future<String> createAdvertisement(
    RequestCreateAdvertisement advertisement,
  ) async {
    try {
      // Создаем модель для передачи данных
      final requestModel = RequestCreateAdvertisementModel(
        title: advertisement.title,
        wanted_job: advertisement.wanted_job,
        description: advertisement.description,
        salary: advertisement.salary,
        date: advertisement.date,
        time_start: advertisement.time_start,
        time_end: advertisement.time_end,
        address: advertisement.address,
        is_urgent: advertisement.is_urgent,
        xp: advertisement.xp,
        age: advertisement.age,
        car: advertisement.car,
        city: advertisement.city,
      );

      final message = await remoteDataSource.createAdvertisement(requestModel);
      return message;
    } catch (e) {
      throw Exception('Ошибка создания обьявления: ${e.toString()}');
    }
  }


  @override
  Future<String> reductAdvertisement(
    RequestCreateAdvertisement advertisement,
    int job_id
  ) async {
    try {
      // Создаем модель для передачи данных
      final requestModel = RequestCreateAdvertisementModel(
        title: advertisement.title,
        wanted_job: advertisement.wanted_job,
        description: advertisement.description,
        salary: advertisement.salary,
        date: advertisement.date,
        time_start: advertisement.time_start,
        time_end: advertisement.time_end,
        address: advertisement.address,
        is_urgent: advertisement.is_urgent,
        xp: advertisement.xp,
        age: advertisement.age,
        car: advertisement.car,
        city: advertisement.city,
      );

      // Отправляем данные через remoteDataSource и возвращаем сообщение
      final message = await remoteDataSource.reductAdvertisement(requestModel, job_id);
      return message;
    } catch (e) {
      // Преобразуем ошибку в более удобный формат
      throw Exception('Ошибка в редактировании обьявления: ${e.toString()}');
    }
  }

  @override
  Future<String> deleteAdvertisement(int job_id) async {
    try {
      final message = await remoteDataSource.deleteAdvertisement(job_id);
      return message;
    } catch (e) {
      throw Exception('Ошибка удаления обьявления: ${e.toString()}');
    }
  }
}
