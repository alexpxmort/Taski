import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taski/app/app.dart';

void main() {
  runApp(const ProviderScope(child: TaskiApp()));
}
