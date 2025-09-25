import 'package:work_assistent_mob/domain/entities/address_suggestion.dart';
import 'package:work_assistent_mob/data/datasources/remote/address_remote_data_source.dart';
import 'package:work_assistent_mob/domain/repositories/address_repository.dart';

class AddressRepositoryImpl implements AddressRepository {
  final AddressRemoteDataSource remoteDataSource;

  AddressRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<AddressSuggestion>> suggestAddress(String query) async {
    try {
      final suggestions = await remoteDataSource.suggestAddress(query);
      return suggestions.map((suggestion) => AddressSuggestion.fromJson(suggestion)).toList();
    } catch (e) {
      throw Exception('Ошибка получения совпадений в адресе: $e');
    }
  }
}