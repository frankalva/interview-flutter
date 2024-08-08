class City {
  final String key;
  final String localizedName;
  final String country;
  final String administrativeArea;
  String? description;
  String? weatherText;
  int? weatherIcon;
  String? localObservationDateTime;

  City({
    required this.key,
    required this.localizedName,
    required this.country,
    required this.administrativeArea,
    this.description,
    this.weatherText,
    this.weatherIcon,
    this.localObservationDateTime,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      key: json['Key'],
      localizedName: json['LocalizedName'],
      country: json['Country']['LocalizedName'],
      administrativeArea: json['AdministrativeArea']['LocalizedName'],
    );
  }
}