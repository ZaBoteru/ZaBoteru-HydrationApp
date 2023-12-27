import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:zaboteru/services/utilities.dart';

Future<void> notifySterilization() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'key',
      title: '${Emojis.wheater_droplet} Done Sterilization!',
      body: 'Your bottle is safe to drink from ${Emojis.emotion_red_heart}',
      notificationLayout: NotificationLayout.Default,
    ),
  );
}

Future<void> notifyRifilling() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'refilling_channel',
      title: '${Emojis.wheater_droplet} Your bottle is empty!',
      body: 'Your bottle needs a refill.',
      notificationLayout: NotificationLayout.Default,
    ),
  );
}
