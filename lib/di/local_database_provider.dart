import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_submission_2/data/local/local_database_services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_database_provider.g.dart';

@riverpod
LocalDatabaseServices databaseServices(Ref ref) => LocalDatabaseServices();
