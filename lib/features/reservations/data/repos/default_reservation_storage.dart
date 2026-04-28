import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:temy_barber/features/reservations/data/models/default_reservation.dart';

class DefaultReservationStorage {
  static const _storageKey = 'default_reservation';

  Future<DefaultReservation?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final reservationJson = prefs.getString(_storageKey);

    if (reservationJson == null) return null;

    try {
      final data = jsonDecode(reservationJson);
      if (data is! Map<String, dynamic>) return null;

      final reservation = DefaultReservation.fromJson(data);
      return reservation.isValid ? reservation : null;
    } catch (_) {
      return null;
    }
  }

  Future<void> save(DefaultReservation reservation) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, jsonEncode(reservation.toJson()));
  }

  Future<void> remove() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }
}
