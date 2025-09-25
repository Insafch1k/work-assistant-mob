// domain/entities/address_suggestion.dart
class AddressSuggestion {
  final String value;
  final String unrestrictedValue;
  final Map<String, dynamic> data;

  AddressSuggestion({
    required this.value,
    required this.unrestrictedValue,
    required this.data,
  });

  factory AddressSuggestion.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};

    return AddressSuggestion(
      value: json['value'] ?? '',
      unrestrictedValue: json['unrestricted_value'] ?? '',
      data: data,
    );
  }

  String get city {
    return data['city'] ?? data['settlement'] ?? data['region'] ?? '';
  }

  String get addressWithoutCity {
    final street = data['street'] ?? '';
    final house = data['house'] ?? '';
    final building = data['building'] ?? '';

    if (street.isEmpty) return '';

    String result = street;
    if (house.isNotEmpty) result += ', $house';
    if (building.isNotEmpty) result += ', $building';

    return result;
  }

  String get fullAddress {
    if (city.isEmpty && addressWithoutCity.isEmpty) return value;
    if (city.isEmpty) return addressWithoutCity;
    if (addressWithoutCity.isEmpty) return city;
    return '$city, $addressWithoutCity';
  }

  bool isCityOnly() {
    final settlementType = data['settlement_type'] ?? data['settlement_type_full'] ?? '';
    
    final hasStreet = data['street'] != null && (data['street'] as String).isNotEmpty;
    final hasHouse = data['house'] != null && (data['house'] as String).isNotEmpty;
    final hasBuilding = data['building'] != null && (data['building'] as String).isNotEmpty;
    
    return (settlementType.toString().toLowerCase().contains('город') ||
            settlementType.toString().toLowerCase().contains('city')) ||
           (city.isNotEmpty && !hasStreet && !hasHouse && !hasBuilding);
  }
}