import 'dart:convert';
import 'dart:io';

import 'package:cat_images/domain/models/cat_image.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class CatRepository {
  final http.Client _client;

  CatRepository(this._client);

  Future<SecurityContext> get globalContext async {
    final sslCert = await rootBundle.load('certificate/thecatapi.pem');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
    return securityContext;
  }

  Future<CatImage> getCatImage() async {
    HttpClient client = HttpClient(context: await globalContext);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(client);
    final response = await ioClient
        .get(Uri.parse('https://api.thecatapi.com/v1/images/search'));
    return CatImage.fromJson(jsonDecode(response.body)[0]);
  }
}
