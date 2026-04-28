import 'package:temy_barber/features/barber/data/models/barber_detail_response.dart';
import 'package:temy_barber/features/barber/data/models/reservation_arguments.dart';

class DefaultReservation {
  final BarberDetailData barber;
  final List<BarberService> services;
  final double totalPrice;

  DefaultReservation({
    required this.barber,
    required this.totalPrice,
    required List<BarberService> services,
  }) : services = List.unmodifiable(services);

  factory DefaultReservation.fromJson(Map<String, dynamic> json) {
    final barberJson = _asMap(json['barber']);
    final serviceJsonList = _asList(json['services']);

    return DefaultReservation(
      barber: _barberFromJson(barberJson),
      services: serviceJsonList
          .map(_asMap)
          .map(_serviceFromJson)
          .whereType<BarberService>()
          .toList(),
      totalPrice: _asDouble(json['totalPrice']),
    );
  }

  int get totalDuration =>
      services.fold(0, (sum, service) => sum + service.duration);

  bool get isValid => barber.id.isNotEmpty && services.isNotEmpty;

  ReservationArguments toReservationArguments({BarberDetailData? barberData}) {
    return ReservationArguments(
      selectedServices: services,
      barberData: barberData ?? barber,
      totalPrice: totalPrice,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'barber': {
        'id': barber.id,
        'name': barber.name,
        'avatar': barber.avatar,
        'about': barber.about,
        'portfolioImages': barber.portfolioImages,
        'maxReservationDays': barber.maxReservationDays,
        'workingHours': {
          'start': barber.workingHours.start,
          'end': barber.workingHours.end,
          'daysOff': barber.workingHours.daysOff,
        },
        'rating': {
          'average': barber.rating.average,
          'total': barber.rating.total,
        },
      },
      'services': services
          .map(
            (service) => {
              'id': service.id,
              'name': service.name,
              'price': service.price,
              'duration': service.duration,
              'category': service.category,
              'imageCover': service.imageCover,
            },
          )
          .toList(),
      'totalPrice': totalPrice,
    };
  }

  static BarberDetailData _barberFromJson(Map<String, dynamic> json) {
    final workingHoursJson = _asMap(json['workingHours']);
    final ratingJson = _asMap(json['rating']);

    return BarberDetailData(
      id: _asString(json['id']),
      name: _asString(json['name']),
      avatar: _asString(json['avatar']),
      about: json['about']?.toString(),
      portfolioImages: _asStringList(json['portfolioImages']),
      maxReservationDays: _asInt(json['maxReservationDays'], fallback: 30),
      workingHours: WorkingHours(
        start: _asString(workingHoursJson['start'], fallback: '09:00'),
        end: _asString(workingHoursJson['end'], fallback: '21:00'),
        daysOff: _asIntList(workingHoursJson['daysOff']),
      ),
      rating: Rating(
        average: _asDouble(ratingJson['average']),
        total: _asInt(ratingJson['total']),
      ),
      services: [],
      availability: Availability(date: DateTime.now().toString(), slots: []),
    );
  }

  static BarberService? _serviceFromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final name = json['name'];
    final price = json['price'];
    final duration = json['duration'];
    final category = json['category'];

    if (id == null ||
        name == null ||
        price == null ||
        duration == null ||
        category == null) {
      return null;
    }

    return BarberService(
      id: id.toString(),
      name: name.toString(),
      price: _asInt(price),
      duration: _asInt(duration),
      category: category.toString(),
      imageCover: json['imageCover']?.toString(),
    );
  }

  static Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map((key, value) => MapEntry(key.toString(), value));
    }
    return {};
  }

  static List<dynamic> _asList(dynamic value) {
    if (value is List) return value;
    return [];
  }

  static String _asString(dynamic value, {String fallback = ''}) {
    return value?.toString() ?? fallback;
  }

  static int _asInt(dynamic value, {int fallback = 0}) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? fallback;
  }

  static double _asDouble(dynamic value, {double fallback = 0}) {
    if (value is double) return value;
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? fallback;
  }

  static List<int> _asIntList(dynamic value) {
    return _asList(value)
        .map((item) => _asInt(item, fallback: -1))
        .where((item) => item >= 0)
        .toList();
  }

  static List<String> _asStringList(dynamic value) {
    return _asList(value).map((item) => item.toString()).toList();
  }
}
