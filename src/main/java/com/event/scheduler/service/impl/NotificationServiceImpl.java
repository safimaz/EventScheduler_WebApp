package com.event.scheduler.service.impl;

import java.util.List;

import com.event.scheduler.dao.NotificationDAO;
import com.event.scheduler.dao.impl.NotificationDAOImpl;
import com.event.scheduler.model.Notification;
import com.event.scheduler.service.NotificationService;

public class NotificationServiceImpl implements NotificationService {

    private NotificationDAO notificationDAO;

    // Constructor
    public NotificationServiceImpl() {
        this.notificationDAO = new NotificationDAOImpl();
    }

    @Override
    public boolean addNotification(Notification notification) {

        if (notification == null) {
            return false;
        }

        if (notification.getUserId() <= 0) {
            return false;
        }

        if (notification.getMessage() == null
                || notification.getMessage().trim().isEmpty()) {
            return false;
        }

        // New notifications should be unread
        if (notification.getIsRead() == null
                || notification.getIsRead().trim().isEmpty()) {
            notification.setIsRead("N");
        }

        return notificationDAO.addNotification(notification);
    }

    @Override
    public List<Notification> getNotificationsByUser(int userId) {

        if (userId <= 0) {
            return List.of();
        }

        return notificationDAO.getNotificationsByUser(userId);
    }

    @Override
    public List<Notification> getUnreadNotificationsByUser(int userId) {

        if (userId <= 0) {
            return List.of();
        }

        return notificationDAO.getUnreadNotificationsByUser(userId);
    }

    @Override
    public int getUnreadNotificationCount(int userId) {

        if (userId <= 0) {
            return 0;
        }

        return notificationDAO.getUnreadNotificationCount(userId);
    }

    @Override
    public boolean markAsRead(int notificationId) {

        if (notificationId <= 0) {
            return false;
        }

        return notificationDAO.markAsRead(notificationId);
    }

    @Override
    public boolean markAllAsRead(int userId) {

        if (userId <= 0) {
            return false;
        }

        return notificationDAO.markAllAsRead(userId);
    }
}