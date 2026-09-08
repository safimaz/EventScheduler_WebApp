package com.event.scheduler.service;

import java.util.List;

import com.event.scheduler.model.Notification;

public interface NotificationService {

    // Create a notification
    boolean addNotification(Notification notification);

    // Get all notifications for a user
    List<Notification> getNotificationsByUser(int userId);

    // Get unread notifications for a user
    List<Notification> getUnreadNotificationsByUser(int userId);

    // Get unread notification count
    int getUnreadNotificationCount(int userId);

    // Mark one notification as read
    boolean markAsRead(int notificationId, int userId);

    // Mark all notifications as read for a user
    boolean markAllAsRead(int userId);
}