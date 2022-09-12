import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:starbucks_clonecoding/ui/screen/home_screen.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'SeoulNamsanEB',
        ),
        home: HomeScreen(),
      ),
    ),
  );
}
