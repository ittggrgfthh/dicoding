import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyek3/common/styles.dart';
import 'package:proyek3/provider/preferences_provider.dart';
import 'package:proyek3/provider/scheduling_provider.dart';
import 'package:proyek3/widget/custom_dialog.dart';
import 'package:proyek3/widget/platform_widget.dart';

class SettingsPage extends StatelessWidget {
  static const String settingsTitle = 'Settings';
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          settingsTitle,
        ),
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(
          settingsTitle,
          style: TextStyle(
            color: foregroundColor,
          ),
        ),
        backgroundColor: backgroundColor,
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, preferences, child) => ListView(
        children: [
          Material(
            child: ListTile(
              tileColor: itemForegroundColor,
              textColor: backgroundColor,
              title: const Text('Dark Theme'),
              trailing: Switch.adaptive(
                value: false,
                onChanged: (value) {
                  defaultTargetPlatform == TargetPlatform.iOS
                      ? showCupertinoDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              title: const Text('Coming Soon!'),
                              content: const Text(
                                  'This feature will be coming soon!'),
                              actions: [
                                CupertinoDialogAction(
                                  child: const Text('Ok'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        )
                      : showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: itemForegroundColor,
                              title: const Text('Coming Soon!'),
                              content: const Text(
                                  'This feature will be coming soon!'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Ok'),
                                )
                              ],
                            );
                          },
                        );
                },
              ),
            ),
          ),
          Material(
            child: ListTile(
              tileColor: itemForegroundColor,
              textColor: backgroundColor,
              title: const Text('Restaurant Notification'),
              trailing: Consumer<SchedulingProvider>(
                builder: (context, scheduled, _) {
                  return Switch.adaptive(
                    value: preferences.isDailyNotificationActive,
                    onChanged: (value) async {
                      if (Platform.isIOS) {
                        customDialog(context);
                      } else {
                        scheduled.scheduledRestaurants(value);
                        preferences.enableDailyNotification(value);
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
