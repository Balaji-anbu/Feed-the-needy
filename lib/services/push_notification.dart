import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> sendPushNotification({
  required String title,
  required String message,
  String? targetTag, // Optional: Tag for targeting users
}) async {
  const String oneSignalAppId = '8e65f1ef-3ae2-4282-ad4d-cee4e5d41c40';
  const String oneSignalApiKey =
      'os_v2_app_rzs7d3z24jbiflknz3solva4ibkishzidhvupvvluq6s2fh6hk3dy5hdlftesckxd3kcfjhqg7aiw4x5nmpni2cefkrnvmskin3vnvi';

  final url = Uri.parse('https://onesignal.com/api/v1/notifications');

  // Construct payload
  final Map<String, dynamic> payload = {
    "app_id": oneSignalAppId,
    "priority": 'high',
    "headings": {"en": title}, // Title of the notification
    "contents": {"en": message}, // Message body

    "filters": targetTag != null
        ? [
            {"field": "tag", "key": "role", "relation": "=", "value": targetTag}
          ]
        : null, // Target users by tag (e.g., "role": "Food Needer")
  };

  // Remove filters if targetTag is null
  if (targetTag == null) {
    payload.remove("filters");
  }

  // Make POST request
  final response = await http.post(
    url,
    headers: {
      "Authorization": "Basic $oneSignalApiKey",
      "Content-Type": "application/json",
    },
    body: json.encode(payload),
  );

  if (response.statusCode == 200) {
    print("Notification sent successfully: ${response.body}");
  } else {
    print("Failed to send notification: ${response.body}");
  }
}

Future<void> sendNotificationToDocId({
  required String title,
  required String message,
  required String docId,
}) async {
  const String oneSignalAppId = '8e65f1ef-3ae2-4282-ad4d-cee4e5d41c40';
  const String oneSignalApiKey =
      'os_v2_app_rzs7d3z24jbiflknz3solva4ibkishzidhvupvvluq6s2fh6hk3dy5hdlftesckxd3kcfjhqg7aiw4x5nmpni2cefkrnvmskin3vnvi';

  final url = Uri.parse('https://onesignal.com/api/v1/notifications');

  final payload = {
    "app_id": oneSignalAppId,
    "priority": 'high',
    "headings": {"en": title},
    "contents": {"en": message},
    "filters": [
      {"field": "tag", "key": "docId", "relation": "=", "value": docId}
    ], // Target users by docId
  };

  try {
    final response = await http.post(
      url,
      headers: {
        "Authorization": "Basic $oneSignalApiKey",
        "Content-Type": "application/json",
      },
      body: json.encode(payload),
    );

    if (response.statusCode == 200) {
      print("Notification sent successfully to Doc ID: $docId");
    } else {
      print("Failed to send notification: ${response.body}");
    }
  } catch (e) {
    print("Error sending notification: $e");
  }
}
