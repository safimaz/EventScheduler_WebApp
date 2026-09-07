package com.event.scheduler.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.event.scheduler.dao.BookingResourceDAO;
import com.event.scheduler.model.BookingResource;
import com.event.scheduler.util.DBConnection;

public class BookingResourceDAOImpl implements BookingResourceDAO {

    @Override
    public boolean addBookingResource(BookingResource bookingResource) {

        String sql = "INSERT INTO booking_resources "
                + "(booking_id, resource_id, quantity) "
                + "VALUES (?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, bookingResource.getBookingId());
            statement.setInt(2, bookingResource.getResourceId());
            statement.setInt(3, bookingResource.getQuantity());

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean addBookingResources(
            List<BookingResource> bookingResources,
            Connection connection) {

        if (bookingResources == null ||
                bookingResources.isEmpty()) {

            return true;
        }

        String sql = "INSERT INTO booking_resources "
                + "(booking_id, resource_id, quantity) "
                + "VALUES (?, ?, ?)";

        try (PreparedStatement statement =
                connection.prepareStatement(sql)) {

            for (BookingResource bookingResource
                    : bookingResources) {

                statement.setInt(
                        1,
                        bookingResource.getBookingId());

                statement.setInt(
                        2,
                        bookingResource.getResourceId());

                statement.setInt(
                        3,
                        bookingResource.getQuantity());

                statement.addBatch();
            }

            int[] results =
                    statement.executeBatch();

            for (int result : results) {

                if (result == 0) {
                    return false;
                }
            }

            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    

    @Override
    public boolean addBookingResources(List<BookingResource> bookingResources) {

        if (bookingResources == null || bookingResources.isEmpty()) {
            return true;
        }

        String sql = "INSERT INTO booking_resources "
                + "(booking_id, resource_id, quantity) "
                + "VALUES (?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            for (BookingResource bookingResource: bookingResources) {

                statement.setInt(1,bookingResource.getBookingId());

                statement.setInt(2,bookingResource.getResourceId());

                statement.setInt(3,bookingResource.getQuantity());

                statement.addBatch();
            }

            int[] results = statement.executeBatch();

            for (int result : results) {

                if (result == 0) {
                    return false;
                }
            }

            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<BookingResource> getResourcesByBooking(int bookingId) {

        List<BookingResource> bookingResources = new ArrayList<>();

        String sql = "SELECT booking_id, resource_id, quantity "
                + "FROM booking_resources "
                + "WHERE booking_id = ? "
                + "ORDER BY resource_id";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, bookingId);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {
                    bookingResources.add(mapBookingResource(resultSet));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return bookingResources;
    }

    @Override
    public List<BookingResource> getBookingsByResource(int resourceId) {

        List<BookingResource> bookingResources =new ArrayList<>();

        String sql = "SELECT booking_id, resource_id, quantity "
                + "FROM booking_resources "
                + "WHERE resource_id = ? "
                + "ORDER BY booking_id";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, resourceId);

            try (ResultSet resultSet =statement.executeQuery()) {

                while (resultSet.next()) {

                    bookingResources.add(
                            mapBookingResource(resultSet));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return bookingResources;
    }

    @Override
    public boolean deleteBookingResources(int bookingId) {

        String sql = "DELETE FROM booking_resources "
                + "WHERE booking_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =connection.prepareStatement(sql)) {

            statement.setInt(1, bookingId);

            statement.executeUpdate();

            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteBookingResource(int bookingId,int resourceId) {

        String sql = "DELETE FROM booking_resources "
                + "WHERE booking_id = ? "
                + "AND resource_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =connection.prepareStatement(sql)) {

            statement.setInt(1, bookingId);
            statement.setInt(2, resourceId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean isResourceAvailable(
            int resourceId,
            int quantity,
            LocalDateTime startTime,
            LocalDateTime endTime) {

        String sql =
                "SELECT r.quantity - NVL(SUM(br.quantity), 0) "
                + "FROM resources r "
                + "LEFT JOIN booking_resources br "
                + "ON r.resource_id = br.resource_id "
                + "AND br.booking_id IN ("
                + "SELECT b.booking_id "
                + "FROM bookings b "
                + "WHERE b.status = 'CONFIRMED' "
                + "AND (? < b.end_time "
                + "AND ? > b.start_time)"
                + ") "
                + "WHERE r.resource_id = ? "
                + "GROUP BY r.quantity";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =connection.prepareStatement(sql)) {

            statement.setTimestamp(1,java.sql.Timestamp.valueOf(startTime));

            statement.setTimestamp(2,java.sql.Timestamp.valueOf(endTime));

            statement.setInt(3, resourceId);

            try (ResultSet resultSet =statement.executeQuery()) {

                if (resultSet.next()) {

                    int availableQuantity =resultSet.getInt(1);

                    return availableQuantity >= quantity;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    private BookingResource mapBookingResource(
            ResultSet resultSet) throws Exception {

        BookingResource bookingResource =
                new BookingResource();

        bookingResource.setBookingId(
                resultSet.getInt("booking_id"));

        bookingResource.setResourceId(
                resultSet.getInt("resource_id"));

        bookingResource.setQuantity(
                resultSet.getInt("quantity"));

        return bookingResource;
    }
}