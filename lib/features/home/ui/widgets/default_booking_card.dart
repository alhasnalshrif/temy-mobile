import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temy_barber/core/routing/routes.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/features/barber/data/models/barber_detail_response.dart';
import 'package:temy_barber/features/barber/data/models/reservation_arguments.dart';
import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';

class DefaultBookingCard extends StatefulWidget {
  const DefaultBookingCard({Key? key}) : super(key: key);

  @override
  State<DefaultBookingCard> createState() => _DefaultBookingCardState();
}

class _DefaultBookingCardState extends State<DefaultBookingCard> {
  bool _isLoading = true;
  Map<String, dynamic>? _defaultReservation;

  @override
  void initState() {
    super.initState();
    _loadDefaultReservation();
  }

  Future<void> _loadDefaultReservation() async {
    final prefs = await SharedPreferences.getInstance();
    final reservationJson = prefs.getString('default_reservation');

    setState(() {
      _isLoading = false;
      if (reservationJson != null) {
        _defaultReservation = jsonDecode(reservationJson);
      }
    });
  }

  Future<void> _removeDefaultBooking() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('default_reservation');

    setState(() {
      _defaultReservation = null;
    });

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('default_booking.removed'.tr()),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red[700],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading || _defaultReservation == null) {
      return const SizedBox.shrink();
    }

    final barberData = _defaultReservation!['barber'];
    final services =
        List<Map<String, dynamic>>.from(_defaultReservation!['services']);
    final totalPrice = _defaultReservation!['totalPrice'].toDouble();

    int totalDuration = 0;
    for (var service in services) {
      totalDuration += service['duration'] as int;
    }

    return Dismissible(
      key: const Key('default_booking_card'),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        _removeDefaultBooking();
      },
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            title: Text('default_booking.remove_title'.tr()),
            content: Text('default_booking.remove_confirmation'.tr()),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('default_booking.cancel'.tr()),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(
                  'default_booking.remove'.tr(),
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        );
      },
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.red[700],
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        decoration: BoxDecoration(
          color: ColorsManager.lightBlue,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: barberData['avatar'] != null
                    ? NetworkImage(barberData['avatar'])
                    : null,
                backgroundColor: Colors.grey[200],
                child: barberData['avatar'] == null
                    ? const Icon(Icons.person, color: Colors.grey, size: 16)
                    : null,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'default_booking.best_choice'.tr(),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      barberData['name'] ?? 'مصفف الشعر',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${services.length} ${'default_booking.services'.tr()} · ${(totalDuration / 60).ceil()} ${'default_booking.hour'.tr()}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    ' $totalPrice جنيه',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.mainBlue,
                        ),
                  ),
                  const SizedBox(height: 4),
                  ElevatedButton(
                    onPressed: () {
                      List<BarberService> barberServices =
                          services.map((service) {
                        return BarberService(
                          id: service['id'],
                          name: service['name'],
                          price: service['price'],
                          duration: service['duration'],
                          category: service['category'],
                          imageCover: service['imageCover'],
                        );
                      }).toList();

                      final barberDetail = BarberDetailData(
                        id: barberData['id'],
                        name: barberData['name'],
                        avatar: barberData['avatar'],
                        portfolioImages: [],
                        maxReservationDays: 30,
                        workingHours: WorkingHours(
                          start: '09:00',
                          end: '21:00',
                          daysOff: [],
                        ),
                        rating: Rating(
                          average: 0,
                          total: 0,
                        ),
                        services: [],
                        availability: Availability(
                          date: DateTime.now().toString(),
                          slots: [],
                        ),
                      );

                      final args = ReservationArguments(
                        selectedServices: barberServices,
                        barberData: barberDetail,
                        totalPrice: totalPrice,
                      );
                      Navigator.pushNamed(
                        context,
                        Routes.reservationScreen,
                        arguments: args,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorsManager.mainBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      minimumSize: const Size(80, 32),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          size: 12,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'default_booking.book_now'.tr(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
