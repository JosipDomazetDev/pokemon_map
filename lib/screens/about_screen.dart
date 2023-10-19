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
          return Scaffold(
            appBar: AppBar(
              title: const Text('Josip Domazet'),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: AssetImage('assets/profile.jpg'),
                    ),
                  ),
                ),
                Center(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Skills: Mobile Development & Flutter',
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                    Text('App Version: ${info!.version}',
                        style:
                            const TextStyle(fontSize: 11.0, color: Colors.grey))
                  ],
                )),
              ],
            ),
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
