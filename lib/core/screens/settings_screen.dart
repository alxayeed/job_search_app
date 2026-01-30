import 'package:flutter/material.dart';
import '../widgets/quota_info_widget.dart';
import '../../core/services/app_info_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ExpansionTile(
            title: const Text('API Usage'),
            leading: const Icon(Icons.storage),
            children: const [
              ApiQuotaWidget(),
            ],
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {},
          ),
          const SizedBox(height: 16),
          FutureBuilder<AppVersion>(
            future: AppInfoService().getVersion(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const ListTile(
                  leading: Icon(Icons.app_settings_alt),
                  title: Text('App Version: Not Available'),
                );
              }
              return ListTile(
                leading: const Icon(Icons.app_settings_alt),
                title: Text('App Version: ${snapshot.data.toString()}'),
              );
            },
          ),
        ],
      ),
    );
  }
}
