import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/history_provider.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final historyProvider = Provider.of<HistoryProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Riwayat Kehadiran')),
      body: ListView.builder(
        itemCount: historyProvider.history.length,
        itemBuilder: (context, index) {
          final record = historyProvider.history[index];
          return ListTile(
            title: Text(record.date),
            subtitle: Text('Hadir: ${record.presentCount}, Tidak Hadir: ${record.absentCount}'),
          );
        },
      ),
    );
  }
}