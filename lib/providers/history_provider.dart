import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/Model/riwayat_kehadiran.dart';

class HistoryProvider with ChangeNotifier {
  final List<RiwayatKehadiran> _history = [];

  List<RiwayatKehadiran> get history => _history;

  // Menambahkan riwayat kehadiran
  void addRecord(RiwayatKehadiran record) {
    _history.insert(0, record);
    notifyListeners();
  }
}