package com.event.scheduler.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.event.scheduler.dao.NotificationDAO;
import com.event.scheduler.model.Notification;
import com.event.scheduler.util.DBConnection;

public class NotificationDAOImpl implements NotificationDAO {

    @Override
    public boolean addNotification(Notification notification) {

        String sql = "INSERT INTO notifications "
                   + "(user_id, message, type, is_read) "
                   + "VALUES (?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, notification.getUserId());
            preparedStatement.setString(2, notification.getMessage());
            preparedStatement.setString(3, notification.getType());
            preparedStatement.setString(4, notification.getIsRead());

            return preparedStatement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public List<Notification> getNotificationsByUser(int userId) {

        List<Notification> notifications = new ArrayList<>();

        String sql = "SELECT notification_id, user_id, message, type, "
                   + "is_read, created_at "
                   + "FROM notifications "
                   + "WHERE user_id = ? "
                   + "ORDER BY created_at DESC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, userId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {

                while (resultSet.next()) {
                    notifications.add(mapNotification(resultSet));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return notifications;
    }

    @Override
    public List<Notification> getUnreadNotificationsByUser(int userId) {

        List<Notification> notifications = new ArrayList<>();

        String sql = "SELECT notification_id, user_id, message, type, "
                   + "is_read, created_at "
                   + "FROM notifications "
                   + "WHERE user_id = ? "
                   + "AND is_read = 'N' "
                   + "ORDER BY created_at DESC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, userId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {

                while (resultSet.next()) {
                    notifications.add(mapNotification(resultSet));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return notifications;
    }

    @Override
    public int getUnreadNotificationCount(int userId) {

        String sql = "SELECT COUNT(*) "
                   + "FROM notifications "
                   + "WHERE user_id = ? "
                   + "AND is_read = 'N'";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, userId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {

                if (resultSet.next()) {
                    return resultSet.getInt(1);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    @Override
    public boolean markAsRead(int notificationId) {

        String sql = "UPDATE notifications "
                   + "SET is_read = 'Y' "
                   + "WHERE notification_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, notificationId);

            return preparedStatement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean markAllAsRead(int userId) {

        String sql = "UPDATE notifications "
                   + "SET is_read = 'Y' "
                   + "WHERE user_id = ? "
                   + "AND is_read = 'N'";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, userId);

            return preparedStatement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    /**
     * Converts a ResultSet row into a Notification object.
     */
    private Notification mapNotification(ResultSet resultSet)
            throws SQLException {

        int notificationId = resultSet.getInt("notification_id");
        int userId = resultSet.getInt("user_id");
        String message = resultSet.getString("message");
        String type = resultSet.getString("type");
        String isRead = resultSet.getString("is_read");

        Timestamp timestamp = resultSet.getTimestamp("created_at");

        Notification notification = new Notification();

        notification.setNotificationId(notificationId);
        notification.setUserId(userId);
        notification.setMessage(message);
        notification.setType(type);
        notification.setIsRead(isRead);

        if (timestamp != null) {
            notification.setCreatedAt(timestamp.toLocalDateTime());
        }

        return notification;
    }
}