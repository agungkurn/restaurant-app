import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_submission_2/di/local_database_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_in_list_provider.g.dart';

@riverpod
Future<bool> isInSavedPlaces(Ref ref, String id) async {
  final db = ref.watch(databaseServicesProvider);
  final list = await db.getAllItems();
  return list.any((item) => item.id == id);
}
