import 'package:flutter_submission_2/notification/notification_service.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_service_provider.g.dart';

@riverpod
LocalNotificationService notificationService(Ref ref) =>
    LocalNotificationService()..init();
