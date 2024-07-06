import 'dart:async';

class TimeController {
  final StreamController<DateTime> _timeStreamController =
      StreamController<DateTime>.broadcast();

  TimeController() {
    // Mengirim waktu setiap detik
    Timer.periodic(const Duration(seconds: 1), (timer) {
      final currentTime = DateTime.now();
      _timeStreamController.add(currentTime);
    });
  }

  Stream<DateTime> get timeStream => _timeStreamController.stream;

  void dispose() {
    _timeStreamController.close();
  }
}
