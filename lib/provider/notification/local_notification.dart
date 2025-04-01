import 'package:flutter_submission_2/di/notification_service_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../notification/notification_service.dart';

part 'local_notification.g.dart';

@riverpod
class LocalNotification extends _$LocalNotification {
  LocalNotificationService get _flutterNotificationService =>
      ref.read(notificationServiceProvider);

  int _notificationId = 101;

  Future<bool> build() async {
    return await _flutterNotificationService.requestPermission() == true;
  }

  void scheduleNotification() {
    _flutterNotificationService.scheduleNotification(
      id: _notificationId,
      title: "Makan bang",
      body: "Udah siang nih, makan bang?",
    );
  }

  void cancelNotification() {
    _flutterNotificationService.cancelNotification(_notificationId);
  }
}
