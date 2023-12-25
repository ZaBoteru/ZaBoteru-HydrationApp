import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:zaboteru/services/utilities.dart';

Future<void> notifySterilization() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'key',
      badge: 1,
      title: '${Emojis.wheater_droplet} Done Sterilization!',
      body: 'Your bottle is safe to drink from ${Emojis.emotion_red_heart}',
      notificationLayout: NotificationLayout.Default,
    ),
  );
}
