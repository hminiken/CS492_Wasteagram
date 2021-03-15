import 'package:flutter/material.dart';
import 'package:wasteagram/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'dart:async';

const DSN_URL =
    'https://77e04102fb334448b756108c10374f4b@o551740.ingest.sentry.io/5675443';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SentryFlutter.init(
    (options) => options.dsn = DSN_URL,
    appRunner: () => runApp(MyApp()),
  );
}
