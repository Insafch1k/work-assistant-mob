import '../entities/advertisement.dart';

abstract class AdvertisementRepository {
  Future<List<ResponseAdvertisement>> getAdvertisements();
  Future<List<ResponseFilteredAdvertisement>> getFilteredAdvertisements(String city);
  Future<List<ResponseEmployerAdvertisement>> getEmployersAdvertisements();
  Future<DetailedResponseAdvertisement> getDetailedAdvertisement(int job_id);
  Future<List<ResponseAdvertisement>> getAdvertisementsFromHistory();
  Future<List<FavoriteAdvertisement>> getFavoriteAdvertisements();
  Future<void> addAdvertisementToFavorite(int job_id);
  Future<void> deleteAdvertisementFromFavorite(int job_id);
  Future<String> createAdvertisement(RequestCreateAdvertisement advertisement);
  Future<String> reductAdvertisement(RequestCreateAdvertisement advertisement, int job_id);
  Future<String> deleteAdvertisement(int job_id);
}