import 'dart:async';

import 'package:flutter/services.dart';

class ReservationSuccessFeedback {
  const ReservationSuccessFeedback._();

  static void play() {
    unawaited(_play());
  }

  static Future<void> _play() async {
    try {
      await HapticFeedback.heavyImpact();
      await SystemSound.play(SystemSoundType.alert);
      await Future<void>.delayed(const Duration(milliseconds: 120));
      await HapticFeedback.selectionClick();
      await SystemSound.play(SystemSoundType.alert);
    } catch (_) {
      // Feedback is best-effort; booking success must never depend on device APIs.
    }
  }
}
