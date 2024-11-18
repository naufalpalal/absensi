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
                ? null //Jika tidak ada yang hadir maka tombol simpan tidak aktif
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
            child: Text('Simpan Kehadiran'),
          ),
        ],
      ),
    );
  }
}