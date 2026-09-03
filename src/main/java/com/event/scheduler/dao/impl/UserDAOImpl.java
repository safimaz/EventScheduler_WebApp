package com.event.scheduler.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.event.scheduler.dao.UserDAO;
import com.event.scheduler.model.User;
import com.event.scheduler.util.DBConnection;

public class UserDAOImpl implements UserDAO {

    @Override
    public boolean addUser(User user) {

        String sql = "INSERT INTO users "
                + "(name, email, password, role, status) "
                + "VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, user.getName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getPassword());
            statement.setString(4, user.getRole());
            statement.setString(5, user.getStatus());

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public User getUserById(int userId) {

        String sql = "SELECT user_id, name, email, password, role, status "
                + "FROM users WHERE user_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return mapUser(resultSet);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public User getUserByEmail(String email) {

        String sql = "SELECT user_id, name, email, password, role, status "
                + "FROM users WHERE email = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, email);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return mapUser(resultSet);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public List<User> getAllUsers() {

        List<User> users = new ArrayList<>();

        String sql = "SELECT user_id, name, email, password, role, status "
                + "FROM users ORDER BY user_id";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                users.add(mapUser(resultSet));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return users;
    }

    @Override
    public boolean updateUser(User user) {

        String sql = "UPDATE users SET name = ?, email = ?, "
                + "password = ?, role = ?, status = ? "
                + "WHERE user_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, user.getName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getPassword());
            statement.setString(4, user.getRole());
            statement.setString(5, user.getStatus());
            statement.setInt(6, user.getUserId());

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteUser(int userId) {

        String sql = "DELETE FROM users WHERE user_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean validateLogin(String email, String password) {

        String sql = "SELECT COUNT(*) FROM users "
                + "WHERE email = ? "
                + "AND password = ? "
                + "AND status = 'ACTIVE'";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, email);
            statement.setString(2, password);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return resultSet.getInt(1) > 0;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    private User mapUser(ResultSet resultSet) throws Exception {

        User user = new User();

        user.setUserId(resultSet.getInt("user_id"));
        user.setName(resultSet.getString("name"));
        user.setEmail(resultSet.getString("email"));
        user.setPassword(resultSet.getString("password"));
        user.setRole(resultSet.getString("role"));
        user.setStatus(resultSet.getString("status"));

        return user;
    }
}