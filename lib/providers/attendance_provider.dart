import 'package:flutter/foundation.dart';

class AttendanceProvider with ChangeNotifier {
  // Daftar siswa
  final List<Siswa> _students = [
    Siswa(name: 'Ali'),
    Siswa(name: 'Budi'),
    Siswa(name: 'Citra'),
    Siswa(name: 'Naufal'),
  ];

  List<Siswa> get students => _students;

  void toggleAttendance(int index) {
    _students[index].isHadir = !_students[index].isHadir;
    notifyListeners(); // untuk mengganti status kehadiran
  }

  // Reset status hadir siswa
  void resetAttendance() {
    for (var student in _students) {
      student.isHadir = false;
    }
    notifyListeners();//dipanggil untuk memberi tahu UI bahwa data telah berubah.
  }
}

class Siswa {
  final String name;
  bool isHadir;

  Siswa({required this.name, this.isHadir = false});
}