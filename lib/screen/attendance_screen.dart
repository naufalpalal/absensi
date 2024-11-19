import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/attendance_provider.dart';
import '/providers/history_provider.dart';
import '/Model/riwayat_kehadiran.dart';

class AttendanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final attendanceProvider = Provider.of<AttendanceProvider>(context);
    final historyProvider = Provider.of<HistoryProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text('Kehadiran Siswa')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: attendanceProvider.students.length,
              itemBuilder: (context, index) {
                final student = attendanceProvider.students[index];
                return ListTile(
                  leading: Icon(Icons.person), // Ikon di sebelah kiri
                  title: Text(student.name),
                  trailing: Checkbox(
                    value: student.isHadir,
                    onChanged: (_) => attendanceProvider.toggleAttendance(index),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: attendanceProvider.students.every((s) => !s.isHadir)
                ? null
                : () {
                    final presentCount = attendanceProvider.students.where((s) => s.isHadir).length;
                    final absentCount = attendanceProvider.students.length - presentCount;

                    // Tambahkan riwayat kehadiran
                    historyProvider.addRecord(RiwayatKehadiran(
                      date: DateTime.now().toLocal().toString().split(' ')[0],
                      presentCount: presentCount,
                      absentCount: absentCount,
                    ));
                    attendanceProvider.resetAttendance();
                  },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.save), // Ikon untuk tombol simpan
                SizedBox(width: 8),
                Text('Simpan Kehadiran'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}