package com.event.scheduler.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.event.scheduler.dao.RoomDAO;
import com.event.scheduler.model.Room;
import com.event.scheduler.util.DBConnection;

public class RoomDAOImpl implements RoomDAO {

    @Override
    public boolean addRoom(Room room) {

        String sql = "INSERT INTO rooms "
                + "(room_name, capacity, location, description, status) "
                + "VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, room.getRoomName());
            statement.setInt(2, room.getCapacity());
            statement.setString(3, room.getLocation());
            statement.setString(4, room.getDescription());
            statement.setString(5, room.getStatus());

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public Room getRoomById(int roomId) {

        String sql = "SELECT room_id, room_name, capacity, "
                + "location, description, status "
                + "FROM rooms WHERE room_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, roomId);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return mapRoom(resultSet);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public List<Room> getAllRooms() {

        List<Room> rooms = new ArrayList<>();

        String sql = "SELECT room_id, room_name, capacity, "
                + "location, description, status "
                + "FROM rooms ORDER BY room_id";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                rooms.add(mapRoom(resultSet));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return rooms;
    }

    @Override
    public List<Room> getAvailableRooms() {

        List<Room> rooms = new ArrayList<>();

        String sql = "SELECT room_id, room_name, capacity, "
                + "location, description, status "
                + "FROM rooms "
                + "WHERE status = 'AVAILABLE' "
                + "ORDER BY room_id";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                rooms.add(mapRoom(resultSet));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return rooms;
    }

    @Override
    public List<Room> searchRooms(String keyword) {

        List<Room> rooms = new ArrayList<>();

        String sql = "SELECT room_id, room_name, capacity, "
                + "location, description, status "
                + "FROM rooms "
                + "WHERE LOWER(room_name) LIKE ? "
                + "OR LOWER(location) LIKE ? "
                + "OR LOWER(description) LIKE ? "
                + "ORDER BY room_id";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            String searchKeyword = "%" + keyword.toLowerCase() + "%";

            statement.setString(1, searchKeyword);
            statement.setString(2, searchKeyword);
            statement.setString(3, searchKeyword);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {
                    rooms.add(mapRoom(resultSet));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return rooms;
    }

    @Override
    public boolean updateRoom(Room room) {

        String sql = "UPDATE rooms SET "
                + "room_name = ?, "
                + "capacity = ?, "
                + "location = ?, "
                + "description = ?, "
                + "status = ? "
                + "WHERE room_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, room.getRoomName());
            statement.setInt(2, room.getCapacity());
            statement.setString(3, room.getLocation());
            statement.setString(4, room.getDescription());
            statement.setString(5, room.getStatus());
            statement.setInt(6, room.getRoomId());

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteRoom(int roomId) {

        String sql = "DELETE FROM rooms WHERE room_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, roomId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private Room mapRoom(ResultSet resultSet) throws Exception {

        Room room = new Room();

        room.setRoomId(resultSet.getInt("room_id"));
        room.setRoomName(resultSet.getString("room_name"));
        room.setCapacity(resultSet.getInt("capacity"));
        room.setLocation(resultSet.getString("location"));
        room.setDescription(resultSet.getString("description"));
        room.setStatus(resultSet.getString("status"));

        return room;
    }
}