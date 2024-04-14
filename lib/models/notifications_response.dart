class NotificationsResponse {
  List<Notification>? notifications;

  NotificationsResponse({this.notifications});

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic>? notificationsData = json['data'];
    if (notificationsData == null) {
      return NotificationsResponse(notifications: []);
    }

    List<Notification> notificationsList = notificationsData
        .map((notificationJson) => Notification.fromJson(notificationJson))
        .toList();

    return NotificationsResponse(notifications: notificationsList);
  }
}

class Notification {
  String? id;
  String? partnerId;
  String? notificationId;
  bool? isRead;
  NotificationDetail? notificationDetail;

  Notification(
      {this.id,
      this.partnerId,
      this.notificationId,
      this.isRead,
      this.notificationDetail});

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id']?.toString(),
      partnerId: json['partnerId'].toString(),
      notificationId: json['notificationId'].toString(),
      isRead: json['isRead'] as bool?,
      // notificationDetail: json['notification'] as NotificationDetail?
      notificationDetail: json['notification'] != null
          ? NotificationDetail.fromJson(
              json['notification'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> notificationData = {
      'id': id,
      'partnerId': partnerId,
      'notificationId': notificationId,
      'isRead': isRead,
      'notificationDetail': notificationDetail
    };
    return notificationData;
  }
}

// Define a separate class for notification detail
class NotificationDetail {
  String? id;
  String? name;
  String? imageUrl;
  String? description;
  String? type;

  NotificationDetail({
    this.id,
    this.name,
    this.imageUrl,
    this.description,
    this.type,
  });

  factory NotificationDetail.fromJson(Map<String, dynamic> json) {
    return NotificationDetail(
      id: json['id']?.toString(),
      name: json['name'] as String?,
      imageUrl: json['image_url'] as String?,
      description: json['description'] as String?,
      type: json['type'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> detailData = {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
      'type': type,
    };
    return detailData;
  }
}
