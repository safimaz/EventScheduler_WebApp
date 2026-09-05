package com.event.scheduler.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.event.scheduler.dao.BookingDAO;
import com.event.scheduler.model.Booking;
import com.event.scheduler.util.DBConnection;

public class BookingDAOImpl implements BookingDAO {

    @Override
    public boolean addBooking(Booking booking) {

        String sql = "INSERT INTO bookings "
                + "(room_id, user_id, start_time, end_time, "
                + "attendee_count, purpose, status) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, booking.getRoomId());
            statement.setInt(2, booking.getUserId());
            statement.setTimestamp(3,
                    Timestamp.valueOf(booking.getStartTime()));
            statement.setTimestamp(4,
                    Timestamp.valueOf(booking.getEndTime()));
            statement.setInt(5, booking.getAttendeeCount());
            statement.setString(6, booking.getPurpose());
            statement.setString(7, booking.getStatus());

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public Booking getBookingById(int bookingId) {

        String sql = "SELECT booking_id, room_id, user_id, "
                + "start_time, end_time, attendee_count, "
                + "purpose, status, created_at "
                + "FROM bookings "
                + "WHERE booking_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, bookingId);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return mapBooking(resultSet);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public List<Booking> getAllBookings() {

        List<Booking> bookings = new ArrayList<>();

        String sql = "SELECT booking_id, room_id, user_id, "
                + "start_time, end_time, attendee_count, "
                + "purpose, status, created_at "
                + "FROM bookings "
                + "ORDER BY start_time";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                bookings.add(mapBooking(resultSet));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return bookings;
    }

    @Override
    public List<Booking> getBookingsByUser(int userId) {

        List<Booking> bookings = new ArrayList<>();

        String sql = "SELECT booking_id, room_id, user_id, "
                + "start_time, end_time, attendee_count, "
                + "purpose, status, created_at "
                + "FROM bookings "
                + "WHERE user_id = ? "
                + "ORDER BY start_time DESC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {
                    bookings.add(mapBooking(resultSet));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return bookings;
    }

    @Override
    public List<Booking> getBookingsByRoom(int roomId) {

        List<Booking> bookings = new ArrayList<>();

        String sql = "SELECT booking_id, room_id, user_id, "
                + "start_time, end_time, attendee_count, "
                + "purpose, status, created_at "
                + "FROM bookings "
                + "WHERE room_id = ? "
                + "ORDER BY start_time";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, roomId);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {
                    bookings.add(mapBooking(resultSet));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return bookings;
    }

    @Override
    public List<Booking> getBookingsByStatus(String status) {

        List<Booking> bookings = new ArrayList<>();

        String sql = "SELECT booking_id, room_id, user_id, "
                + "start_time, end_time, attendee_count, "
                + "purpose, status, created_at "
                + "FROM bookings "
                + "WHERE status = ? "
                + "ORDER BY start_time";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, status);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {
                    bookings.add(mapBooking(resultSet));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return bookings;
    }

    @Override
    public boolean updateBookingStatus(int bookingId,
                                       String status) {

        String sql = "UPDATE bookings "
                + "SET status = ? "
                + "WHERE booking_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, status);
            statement.setInt(2, bookingId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean cancelBooking(int bookingId) {

        String sql = "UPDATE bookings "
                + "SET status = 'CANCELLED' "
                + "WHERE booking_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, bookingId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean isRoomAvailable(int roomId,
                                   LocalDateTime startTime,
                                   LocalDateTime endTime) {

        String sql = "SELECT COUNT(*) "
                + "FROM bookings "
                + "WHERE room_id = ? "
                + "AND status = 'CONFIRMED' "
                + "AND (? < end_time AND ? > start_time)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, roomId);

            statement.setTimestamp(2,
                    Timestamp.valueOf(startTime));

            statement.setTimestamp(3,
                    Timestamp.valueOf(endTime));

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return resultSet.getInt(1) == 0;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public int getBookingCountForRoom(
            int roomId,
            LocalDateTime startTime,
            LocalDateTime endTime) {

        String sql = "SELECT COUNT(*) "
                + "FROM bookings "
                + "WHERE room_id = ? "
                + "AND status = 'CONFIRMED' "
                + "AND (? < end_time AND ? > start_time)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, roomId);

            statement.setTimestamp(2,
                    Timestamp.valueOf(startTime));

            statement.setTimestamp(3,
                    Timestamp.valueOf(endTime));

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return resultSet.getInt(1);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    @Override
    public List<Booking> getExpiredPendingBookings() {

        List<Booking> bookings = new ArrayList<>();

        String sql = "SELECT booking_id, room_id, user_id, "
                + "start_time, end_time, attendee_count, "
                + "purpose, status, created_at "
                + "FROM bookings "
                + "WHERE status = 'PENDING' "
                + "AND created_at < "
                + "CURRENT_TIMESTAMP - INTERVAL '15' MINUTE "
                + "ORDER BY created_at";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                bookings.add(mapBooking(resultSet));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return bookings;
    }

    @Override
    public boolean markBookingAsExpired(int bookingId) {

        String sql = "UPDATE bookings "
                + "SET status = 'EXPIRED' "
                + "WHERE booking_id = ? "
                + "AND status = 'PENDING'";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, bookingId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private Booking mapBooking(ResultSet resultSet)
            throws Exception {

        Booking booking = new Booking();

        booking.setBookingId(
                resultSet.getInt("booking_id"));

        booking.setRoomId(
                resultSet.getInt("room_id"));

        booking.setUserId(
                resultSet.getInt("user_id"));

        Timestamp startTimestamp =
                resultSet.getTimestamp("start_time");

        if (startTimestamp != null) {
            booking.setStartTime(
                    startTimestamp.toLocalDateTime());
        }

        Timestamp endTimestamp =
                resultSet.getTimestamp("end_time");

        if (endTimestamp != null) {
            booking.setEndTime(
                    endTimestamp.toLocalDateTime());
        }

        booking.setAttendeeCount(
                resultSet.getInt("attendee_count"));

        booking.setPurpose(
                resultSet.getString("purpose"));

        booking.setStatus(
                resultSet.getString("status"));

        Timestamp createdTimestamp =
                resultSet.getTimestamp("created_at");

        if (createdTimestamp != null) {
            booking.setCreatedAt(
                    createdTimestamp.toLocalDateTime());
        }

        return booking;
    }
}