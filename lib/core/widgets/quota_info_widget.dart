import 'dart:async';
import 'package:flutter/material.dart';
import '../services/get_storage_service.dart';
import '../config/api_config.dart';
import 'package:intl/intl.dart';

class ApiQuotaWidget extends StatefulWidget {
  const ApiQuotaWidget({Key? key}) : super(key: key);

  @override
  State<ApiQuotaWidget> createState() => _ApiQuotaWidgetState();
}

class _ApiQuotaWidgetState extends State<ApiQuotaWidget> {
  late final GetStorageService storageService;
  int? quotaLimit;
  int? quotaRemaining;
  int? quotaResetSeconds;
  DateTime? lastChecked;
  Timer? _timer;

  List<String> availableKeys = [];
  String? selectedKey;

  @override
  void initState() {
    super.initState();
    storageService = GetStorageService();
    _loadApiKey();
    _loadQuota();
    _startTimer();
  }

  void _loadApiKey() {
    availableKeys = ApiConfig.availableKeys;
    final savedKey = storageService.jobResultsBox.read('selected_api_key');
    selectedKey = savedKey ?? (availableKeys.isNotEmpty ? availableKeys.first : null);
    ApiConfig.setCurrentKey(selectedKey);
  }

  void _loadQuota() {
    final box = storageService.jobResultsBox;
    final key = selectedKey ?? ApiConfig.currentKey;
    setState(() {
      quotaLimit = box.read('${key}_quota_limit');
      quotaRemaining = box.read('${key}_quota_remaining');
      quotaResetSeconds = box.read('${key}_quota_reset_seconds');
      final lastCheckedString = box.read('${key}_quota_last_checked');
      lastChecked = lastCheckedString != null ? DateTime.tryParse(lastCheckedString) : null;
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (quotaResetSeconds != null && lastChecked != null) setState(() {});
    });
  }

  void _selectApiKey(String key) {
    setState(() {
      selectedKey = key;
      storageService.jobResultsBox.write('selected_api_key', key);
      ApiConfig.setCurrentKey(key);
      _loadQuota();
    });
  }

  String getCountdown() {
    if (quotaResetSeconds == null || lastChecked == null) return 'Not Available';
    final resetTime = lastChecked!.add(Duration(seconds: quotaResetSeconds!));
    final diff = resetTime.difference(DateTime.now());
    if (diff.isNegative) return 'Resetting soon';
    return '${diff.inDays}d ${diff.inHours % 24}h ${diff.inMinutes % 60}m';
  }

  String getResetTimeText() {
    if (quotaResetSeconds == null || lastChecked == null) return 'Not Available';
    final resetTime = lastChecked!.add(Duration(seconds: quotaResetSeconds!));
    return DateFormat('d MMM, h:mm a').format(resetTime);
  }

  String getLastCheckedText() {
    if (lastChecked == null) return 'Not Available';
    return DateFormat('d MMM, h:mm a').format(lastChecked!);
  }

  String getMaskedKey(String? key) {
    if (key == null || key.isEmpty) return 'Not Available';
    final visible = key.length > 6 ? key.substring(0, 6) : key;
    return '$visible*****';
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
                const Icon(Icons.vpn_key, size: 20, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'API Key: ${getMaskedKey(selectedKey)}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.swap_horiz, color: Colors.blueAccent),
                  onPressed: () {
                    if (availableKeys.isEmpty) return;
                    showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return ListView(
                          shrinkWrap: true,
                          children: availableKeys.map((key) {
                            return ListTile(
                              title: Text(getMaskedKey(key)),
                              trailing: selectedKey == key
                                  ? const Icon(Icons.check, color: Colors.green)
                                  : null,
                              onTap: () {
                                _selectApiKey(key);
                                Navigator.pop(context);
                              },
                            );
                          }).toList(),
                        );
                      },
                    );
                  },
                ),
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
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.access_time, size: 20, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  'Last Checked: ${getLastCheckedText()}',
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
