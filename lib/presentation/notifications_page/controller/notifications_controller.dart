import 'package:courier_delivery/core/app_export.dart';
import 'package:courier_delivery/presentation/notifications_page/models/notifications_model.dart';

import '../models/notifications_item_model.dart';

/// A controller class for the NotificationsPage.
///
/// This class manages the state of the NotificationsPage, including the
/// current notificationsModelObj
class NotificationsController extends GetxController {
  List<NotificationsItemModel> notificationData = NotificationsModel.notificationsItemList();
}
