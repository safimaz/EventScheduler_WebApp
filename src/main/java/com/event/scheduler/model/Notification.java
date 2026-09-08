package com.event.scheduler.model;

import java.time.LocalDateTime;

public class Notification {

    private int notificationId;
    private int userId;
    private String message;
    private String type;
    private String isRead;
    private LocalDateTime createdAt;

    // Default constructor
    public Notification() {
    }

    // Constructor without notificationId
    public Notification(
            int userId,
            String message,
            String type,
            String isRead) {

        this.userId = userId;
        this.message = message;
        this.type = type;
        this.isRead = isRead;
    }

    // Full constructor
    public Notification(
            int notificationId,
            int userId,
            String message,
            String type,
            String isRead,
            LocalDateTime createdAt) {

        this.notificationId = notificationId;
        this.userId = userId;
        this.message = message;
        this.type = type;
        this.isRead = isRead;
        this.createdAt = createdAt;
    }

    public int getNotificationId() {
        return notificationId;
    }

    public void setNotificationId(int notificationId) {
        this.notificationId = notificationId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getIsRead() {
        return isRead;
    }

    public void setIsRead(String isRead) {
        this.isRead = isRead;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Notification{" +
                "notificationId=" + notificationId +
                ", userId=" + userId +
                ", message='" + message + '\'' +
                ", type='" + type + '\'' +
                ", isRead='" + isRead + '\'' +
                ", createdAt=" + createdAt +
                '}';
    }
}