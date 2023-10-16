import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  late Future<PackageInfo> packageInfo;

  @override
  void initState() {
    super.initState();
    packageInfo = PackageInfo.fromPlatform();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: packageInfo,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          final info = snapshot.data;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Developer Information:',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              const ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/profile.jpg'),
                  radius: 30.0,
                ),
                title: Text('Josip Domazet'),
                subtitle: Text('Skills: Flutter, Mobile Development'),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'App Version: ${info!.version}',
                    style: const TextStyle(fontSize: 11.0, color: Colors.grey),
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: Text('Failed to load app information.'),
          );
        }
      },
    );
  }
}
