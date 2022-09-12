import 'package:flutter/material.dart';

class ErrorNoInternet extends StatelessWidget {
  const ErrorNoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(
              Icons.wifi_off_rounded,
              size: 50,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Tidak tersambung ke Internet!',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
