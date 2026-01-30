import 'dart:async';
import 'package:flutter/material.dart';
import '../services/get_storage_service.dart';
import 'package:intl/intl.dart';

class QuotaInfoWidget extends StatefulWidget {
  const QuotaInfoWidget({Key? key}) : super(key: key);

  @override
  State<QuotaInfoWidget> createState() => _QuotaInfoWidgetState();
}

class _QuotaInfoWidgetState extends State<QuotaInfoWidget> {
  late final GetStorageService storageService;
  int? quotaLimit;
  int? quotaRemaining;
  DateTime? resetTime;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    storageService = GetStorageService();
    _loadQuota();
    _startTimer();
  }

  void _loadQuota() {
    final box = storageService.jobResultsBox;
    setState(() {
      quotaLimit = box.read('quota_limit');
      quotaRemaining = box.read('quota_remaining');

      final resetTimeString = box.read('quota_reset_time');
      resetTime = resetTimeString != null ? DateTime.tryParse(resetTimeString) : null;
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (resetTime != null) {
        setState(() {}); // triggers rebuild every second for countdown
      }
    });
  }

  String getCountdown() {
    if (resetTime == null) return 'Not Available';
    final diff = resetTime!.difference(DateTime.now());
    if (diff.isNegative) return 'Resetting soon';
    return '${diff.inDays}d ${diff.inHours % 24}h ${diff.inMinutes % 60}m';
  }

  String getResetTimeText() {
    if (resetTime == null) return 'Not Available';
    final formatter = DateFormat('d MMM, h:mm a');
    return formatter.format(resetTime!);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.api, color: Colors.blueAccent),
                SizedBox(width: 8),
                Text('API Request Quota',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.storage, size: 20, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  'Remaining: ${quotaRemaining ?? 'Not Available'} / ${quotaLimit ?? 'Not Available'}',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.timer, size: 20, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  'Countdown: ${getCountdown()}',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.event, size: 20, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  'Reset at: ${getResetTimeText()}',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
