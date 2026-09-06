package com.event.scheduler.service.impl;

import java.sql.Connection;
import java.time.LocalDateTime;
import java.util.List;

import com.event.scheduler.dao.BookingDAO;
import com.event.scheduler.dao.RoomDAO;
import com.event.scheduler.dao.impl.BookingDAOImpl;
import com.event.scheduler.dao.impl.RoomDAOImpl;
import com.event.scheduler.model.Booking;
import com.event.scheduler.model.Room;
import com.event.scheduler.service.BookingService;
import com.event.scheduler.util.DBConnection;

public class BookingServiceImpl
        implements BookingService {

    private final BookingDAO bookingDAO;
    private final RoomDAO roomDAO;

    public BookingServiceImpl() {

        this.bookingDAO = new BookingDAOImpl();
        this.roomDAO = new RoomDAOImpl();
    }

    @Override
    public boolean createBooking(Booking booking) {

        // -----------------------------------------
        // 1. Basic validation
        // -----------------------------------------

        if (booking == null) {
            return false;
        }

        if (booking.getRoomId() <= 0) {
            return false;
        }

        if (booking.getUserId() <= 0) {
            return false;
        }

        if (booking.getStartTime() == null ||
                booking.getEndTime() == null) {

            return false;
        }

        if (!booking.getEndTime()
                .isAfter(booking.getStartTime())) {

            return false;
        }

        if (booking.getAttendeeCount() <= 0) {
            return false;
        }

        // -----------------------------------------
        // 2. Check room exists
        // -----------------------------------------

        Room room =
                roomDAO.getRoomById(
                        booking.getRoomId());

        if (room == null) {
            return false;
        }

        // -----------------------------------------
        // 3. Check room status
        // -----------------------------------------

        if (!"AVAILABLE".equalsIgnoreCase(
                room.getStatus())) {

            return false;
        }

        // -----------------------------------------
        // 4. Check room capacity
        // -----------------------------------------

        if (booking.getAttendeeCount()
                > room.getCapacity()) {

            return false;
        }

        // -----------------------------------------
        // 5. Check room availability
        // -----------------------------------------

        boolean roomAvailable =
                bookingDAO.isRoomAvailable(
                        booking.getRoomId(),
                        booking.getStartTime(),
                        booking.getEndTime());

        if (!roomAvailable) {
            return false;
        }

        // -----------------------------------------
        // 6. Set initial status
        // -----------------------------------------

        booking.setStatus("PENDING");

        // -----------------------------------------
        // 7. Start database transaction
        // -----------------------------------------

        try (Connection connection =
                DBConnection.getConnection()) {

            connection.setAutoCommit(false);

            try {

                // ---------------------------------
                // Create booking
                // ---------------------------------

                int bookingId =
                        bookingDAO.addBooking(
                                booking,
                                connection);

                if (bookingId <= 0) {

                    connection.rollback();

                    return false;
                }

                // ---------------------------------
                // Booking created successfully
                // ---------------------------------

                booking.setBookingId(bookingId);

                // ---------------------------------
                // Commit transaction
                // ---------------------------------

                connection.commit();

                return true;

            } catch (Exception e) {

                connection.rollback();

                e.printStackTrace();

                return false;
            }

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }

    @Override
    public Booking getBookingById(int bookingId) {

        return bookingDAO.getBookingById(bookingId);
    }

    @Override
    public List<Booking> getAllBookings() {

        return bookingDAO.getAllBookings();
    }

    @Override
    public List<Booking> getBookingsByUser(
            int userId) {

        return bookingDAO.getBookingsByUser(userId);
    }

    @Override
    public List<Booking> getBookingsByRoom(
            int roomId) {

        return bookingDAO.getBookingsByRoom(roomId);
    }

    @Override
    public List<Booking> getBookingsByStatus(
            String status) {

        return bookingDAO.getBookingsByStatus(status);
    }

    @Override
    public boolean updateBookingStatus(
            int bookingId,
            String status) {

        if (bookingId <= 0 ||
                status == null ||
                status.trim().isEmpty()) {

            return false;
        }

        return bookingDAO.updateBookingStatus(
                bookingId,
                status.toUpperCase());
    }

    @Override
    public boolean cancelBooking(int bookingId) {

        if (bookingId <= 0) {
            return false;
        }

        return bookingDAO.cancelBooking(bookingId);
    }

    @Override
    public boolean isRoomAvailable(
            int roomId,
            LocalDateTime startTime,
            LocalDateTime endTime) {

        if (roomId <= 0 ||
                startTime == null ||
                endTime == null) {

            return false;
        }

        if (!endTime.isAfter(startTime)) {
            return false;
        }

        return bookingDAO.isRoomAvailable(
                roomId,
                startTime,
                endTime);
    }

    @Override
    public List<Booking> getExpiredPendingBookings() {

        return bookingDAO
                .getExpiredPendingBookings();
    }

    @Override
    public boolean markBookingAsExpired(
            int bookingId) {

        if (bookingId <= 0) {
            return false;
        }

        return bookingDAO
                .markBookingAsExpired(bookingId);
    }
}