import 'package:flutter/material.dart';
import 'package:work_assistent_mob/data/models/advertisement_model.dart';
import 'package:work_assistent_mob/domain/entities/advertisement.dart';
import 'package:work_assistent_mob/domain/usecases/create_favorite_advertisement.dart';
import 'package:work_assistent_mob/domain/usecases/delete_advertisement.dart';
import 'package:work_assistent_mob/domain/usecases/delete_favorite_advertisement.dart';
import 'package:work_assistent_mob/domain/usecases/get_advertisements.dart';
import 'package:work_assistent_mob/domain/usecases/get_advertisements_from_history.dart';
import 'package:work_assistent_mob/domain/usecases/get_detailed_advertisement.dart';
import 'package:work_assistent_mob/domain/usecases/get_employer_advertisements.dart';
import 'package:work_assistent_mob/domain/usecases/get_favorite_advertisements.dart';
import 'package:work_assistent_mob/domain/usecases/create_advertisement.dart';
import 'package:work_assistent_mob/domain/usecases/get_filtered_advertisements.dart';
import 'package:work_assistent_mob/domain/usecases/reduct_advertisement.dart';

class AdvertisementProvider with ChangeNotifier {
  final GetAdvertisements getAdvertisements;
  final GetFilteredAdvertisements getFilteredAdvertisements;
  final GetEmployerAdvertisements getEmployersAdvertisements;
  final GetDetailedAdvertisement getDetailedAdvertisement;
  final GetAdvertisementsFromHistory getAdvertisementsFromHistory;
  final AddAdvertisementToFavorite addAdvertisementToFavorite;
  final DeleteAdvertisementFromFavorite deleteAdvertisementFromFavorite;
  final GetFavoriteAdvertisements getFavoriteAdvertisements;
  final CreateAdvertisement createAdvertisement;
  final ReductAdvertisement reductAdvertisement;
  final DeleteAdvertisement deleteAdvertisement;

  int _currentAdIndex = 0;
  int _currentFilteredAdIndex = 0;
  int _currentEmployerAdIndex = 0;
  int _currentHistoryAdIndex = 0;
  int _currentFavoriteAdIndex = 0;

  List<ResponseAdvertisement> _advertisements = [];
  List<ResponseFilteredAdvertisement> _filteredAdv = [];
  List<ResponseEmployerAdvertisement> _employersAdvertisement = [];
  List<ResponseAdvertisement> _historyAdv = [];
  List<FavoriteAdvertisement> _favoriteAdv = [];
  DetailedResponseAdvertisement? _currentDetailedAd;

  List<String> _cities = [];
  List<String> get cities => _cities;

  List<ResponseAdvertisement> get advertisement => _advertisements;
  List<ResponseFilteredAdvertisement> get filteredAdv => _filteredAdv;
  List<ResponseEmployerAdvertisement> get employerAdvertisement =>
      _employersAdvertisement;
  List<ResponseAdvertisement> get historyAdv => _historyAdv;
  List<FavoriteAdvertisement> get favoriteAdv => _favoriteAdv;
  DetailedResponseAdvertisement? get currentDetailedAd => _currentDetailedAd;

  AdvertisementProvider({
    required this.getAdvertisements,
    required this.getFilteredAdvertisements,
    required this.getEmployersAdvertisements,
    required this.getDetailedAdvertisement,
    required this.getAdvertisementsFromHistory,
    required this.addAdvertisementToFavorite,
    required this.deleteAdvertisementFromFavorite,
    required this.getFavoriteAdvertisements,
    required this.createAdvertisement,
    required this.reductAdvertisement,
    required this.deleteAdvertisement,
  });

  ResponseAdvertisement? get currentAd {
    if (_advertisements.isEmpty) return null;
    return _advertisements[_currentAdIndex];
  }

  ResponseFilteredAdvertisement? get currentFilteredAdIndex {
    if (_filteredAdv.isEmpty) return null;
    return _filteredAdv[_currentFilteredAdIndex];
  }

  ResponseEmployerAdvertisement? get currentEmployerAd {
    if (_employersAdvertisement.isEmpty) return null;
    return _employersAdvertisement[_currentEmployerAdIndex];
  }

  ResponseAdvertisement? get currentHistoryAd {
    if (_historyAdv.isEmpty) return null;
    return _historyAdv[_currentHistoryAdIndex];
  }

  FavoriteAdvertisement? get currentFavoriteAd {
    if (_favoriteAdv.isEmpty) return null;
    return _favoriteAdv[_currentFavoriteAdIndex];
  }

  void nextAd() {
    if (_currentAdIndex < _advertisements.length - 1) {
      _currentAdIndex++;
      notifyListeners();
    }
  }

  void nextFilteredAd() {
    if (_currentFilteredAdIndex < _filteredAdv.length - 1) {
      _currentFilteredAdIndex++;
      notifyListeners();
    }
  }

  void nextEmployerAd() {
    if (_currentEmployerAdIndex < _employersAdvertisement.length - 1) {
      _currentEmployerAdIndex++;
      notifyListeners();
    }
  }

  void nextHistoryAd() {
    if (_currentHistoryAdIndex < _historyAdv.length - 1) {
      _currentHistoryAdIndex++;
      notifyListeners();
    }
  }

  void nextFavoriteAd() {
    if (_currentFavoriteAdIndex < _favoriteAdv.length - 1) {
      _currentFavoriteAdIndex++;
      notifyListeners();
    }
  }

  Future<void> fetchAdvertisements() async {
    try {
      _advertisements = await getAdvertisements();
      extractCitiesFromAdvertisements(_advertisements);
    } catch (e) {
      print("Ошибка $e");
    }
    _currentAdIndex = 0;
    notifyListeners();
  }

  Future<void> fetchFilteredAdvertisements(String city) async {
    try {
      _filteredAdv = await getFilteredAdvertisements(city);
      extractCitiesFromAdvertisements(_filteredAdv);
    } catch (e) {
      print("Ошибка $e");
    }
    _currentFilteredAdIndex = 0;
    notifyListeners();
  }

  void extractCitiesFromAdvertisements(List<dynamic> advertisements) {
    final citySet = <String>{};

    for (var ad in advertisements) {
      if (ad is ResponseAdvertisement &&
          ad.city != null &&
          ad.city!.isNotEmpty) {
        citySet.add(ad.city!);
      } else if (ad is ResponseFilteredAdvertisement &&
          ad.city != null &&
          ad.city!.isNotEmpty) {
        citySet.add(ad.city!);
      }
    }

    _cities = citySet.toList()..sort();
    notifyListeners();
  }

  Future<void> fetchEmployersAdvertisements() async {
    try {
      _employersAdvertisement = await getEmployersAdvertisements();
    } catch (e) {
      print("Ошибка $e");
    }
    _currentEmployerAdIndex = 0;
    notifyListeners();
  }

  Future<void> addToFavorite(int jobId) async {
    try {
      await addAdvertisementToFavorite(jobId);
      await fetchAdvertisements();
      await fetchFavoriteAdvertisements();
      notifyListeners();
    } catch (e) {
      print("Ошибка при добавлении в избранное: $e");
      rethrow;
    }
  }

  Future<void> deleteFromFavorite(int jobId) async {
    try {
      await deleteAdvertisementFromFavorite(jobId);
      await fetchAdvertisements();
      await fetchFavoriteAdvertisements();
      notifyListeners();
    } catch (e) {
      print("Ошибка при удалении из избранного: $e");
      rethrow;
    }
  }

  Future<void> fetchFavoriteAdvertisements() async {
    try {
      final favorites = await getFavoriteAdvertisements();
      _favoriteAdv = favorites;
    } catch (e) {
      print("Ошибка $e");
      _favoriteAdv = [];
    }
    _currentFavoriteAdIndex = 0;
    notifyListeners();
  }

  Future<void> fetchDetailedAdvertisement(int jobId) async {
    try {
      _currentDetailedAd = await getDetailedAdvertisement(jobId);
    } catch (e) {
      print("Ошибка загрузки деталей: $e");
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchAdvertisementsFromHistory() async {
    try {
      _historyAdv = await getAdvertisementsFromHistory();
    } catch (e) {
      print("Ошибка $e");
    }
    _currentHistoryAdIndex = 0;
    notifyListeners();
  }

  Future<String> createAdv(RequestCreateAdvertisement request) async {
    try {
      final message = await createAdvertisement.execute(request);

      await Future.wait([
        fetchAdvertisements(),
        fetchAdvertisementsFromHistory(),
      ]);

      notifyListeners();

      return message;
    } catch (e) {
      print("Ошибка при создании объявления: $e");
      rethrow;
    }
  }

  Future<String> reductAdv(
    RequestCreateAdvertisement request,
    int job_id,
  ) async {
    try {
      final message = await reductAdvertisement.execute(request, job_id);

      await Future.wait([
        fetchAdvertisements(),
        fetchAdvertisementsFromHistory(),
      ]);

      notifyListeners();

      return message;
    } catch (e) {
      print("Ошибка при редактировании объявления: $e");
      rethrow;
    }
  }

  Future<String> deleteAdv(int job_id) async {
    try {
      final message = await deleteAdvertisement(job_id);

      await Future.wait([
        fetchAdvertisements(),
        fetchAdvertisementsFromHistory(),
      ]);

      notifyListeners();

      return message;
    } catch (e) {
      print("Ошибка при редактировании объявления: $e");
      rethrow;
    }
  }
}
