import 'package:flutter/material.dart';
import 'package:recipe/app.dart';
import 'package:recipe/infrasuruktura/repo/storage_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
      url: "https://lpzviytffmntiehesqyl.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxwenZpeXRmZm1udGllaGVzcXlsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM4MjE2MjgsImV4cCI6MjA0OTM5NzYyOH0.naa2flnuVYeX2dntnsdYskcoH4Jz_TCZ3Rsznx-b_X0"
      // url: SUPABASE_URL,
      // anonKey: SUPABASE_ANON_KEY,
      );
  await StorageRepository.getInstance();

  runApp(const AppView());
}
