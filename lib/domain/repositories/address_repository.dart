import 'package:work_assistent_mob/domain/entities/address_suggestion.dart';

abstract class AddressRepository {
  Future<List<AddressSuggestion>> suggestAddress(String query);
}