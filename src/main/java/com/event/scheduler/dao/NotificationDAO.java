package com.event.scheduler.dao;

import java.util.List;

import com.event.scheduler.model.Notification;

public interface NotificationDAO {

    // Create a new notification
    boolean addNotification(Notification notification);

    // Get all notifications for a user
    List<Notification> getNotificationsByUser(int userId);

    // Get unread notifications for a user
    List<Notification> getUnreadNotificationsByUser(int userId);

    // Get unread notification count
    int getUnreadNotificationCount(int userId);

    // Mark a notification as read
    boolean markAsRead(int notificationId);

    // Mark all notifications as read for a user
    boolean markAllAsRead(int userId);
}