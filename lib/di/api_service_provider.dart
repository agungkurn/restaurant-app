import 'package:flutter_submission_2/data/api/api_services.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_service_provider.g.dart';

@riverpod
ApiServices apiServices(Ref ref) => ApiServices();
