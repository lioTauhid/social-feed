import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../service/local/shared_pref.dart';
import '../../../res/components/custom_dialog.dart';
import '../../../res/constants/app_color.dart';
import '../../../res/constants/value.dart';
import '../dashboard/dashboard.dart';

Widget sideDrawer(BuildContext context) {
  return Drawer(
    backgroundColor: primaryBackground,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        UserAccountsDrawerHeader(
          currentAccountPicture: Image.asset("assets/logo_round.png"),
          accountName: const Text(
            (appName),
            style: TextStyle(color: Colors.white),
          ),
          accountEmail: const Text(
            (appVersion),
            style: TextStyle(color: Colors.white),
          ),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/bg.png"), fit: BoxFit.fill)),
        ),
        ListTile(
          title: Text('Theme', style: TextStyle(color: textPrimary)),
          leading: Icon(Icons.dark_mode_outlined, color: textSecondary),
          trailing: DropdownButton<String>(
            items: <String>[
              'Light',
              'Dark',
            ].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(color: textPrimary)),
              );
            }).toList(),
            hint: Text(darkMode ? 'Dark' : 'Light',
                style: TextStyle(color: textPrimary)),
            dropdownColor: secondaryBackground,
            borderRadius: BorderRadius.circular(10),
            onChanged: (value) {
              if (darkMode) {
                darkMode = false;
                applyThem(darkMode);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => const DashBoard()));
              } else {
                darkMode = true;
                applyThem(darkMode);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => const DashBoard()));
              }
            },
          ),
        ),
        Divider(color: textSecondary),
        ListTile(
          title: Text('About Us', style: TextStyle(color: textPrimary)),
          leading: Icon(Icons.star, color: textSecondary),
          onTap: () {
            showCustomDialog(context, 'About Us', about(context), 0, 0);
          },
        ),
        ListTile(
            title: Text("Disclaimer", style: TextStyle(color: textPrimary)),
            onTap: () {
              showCustomDialog(
                  context,
                  "Disclaimer",
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      "The assets and features contained on this app ${appName} is for free and general purposes only. "
                      "${appName} assumes no responsibility for errors or omissions in the contents on the app",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  300,
                  0);
            },
            leading: Icon(Icons.star, color: textSecondary)),
        ListTile(
            title: Text("Privacy Policy", style: TextStyle(color: textPrimary)),
            onTap: () async {
              // webBrowser.openUrlRequest(
              //   urlRequest: URLRequest(url: Uri.parse(privacyPolicy)),
              // );

              // final Uri uri = Uri.parse(privacyPolicy);
              // if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
              //   throw Exception('Could not launch $uri');
              // }
            },
            leading: Icon(
              Icons.star,
              color: textSecondary,
            )),
        ListTile(
            title: Text("Close", style: TextStyle(color: textPrimary)),
            onTap: () {
              Get.back();
            },
            leading: Icon(
              Icons.close,
              color: textSecondary,
            )),
      ],
    ),
  );
}
