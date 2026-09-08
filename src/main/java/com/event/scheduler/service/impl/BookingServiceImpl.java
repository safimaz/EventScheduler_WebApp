package com.event.scheduler.service.impl;

import java.sql.Connection;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import com.event.scheduler.dao.BookingDAO;
import com.event.scheduler.dao.BookingResourceDAO;
import com.event.scheduler.dao.RoomDAO;
import com.event.scheduler.dao.impl.BookingDAOImpl;
import com.event.scheduler.dao.impl.BookingResourceDAOImpl;
import com.event.scheduler.dao.impl.RoomDAOImpl;
import com.event.scheduler.model.Booking;
import com.event.scheduler.model.BookingResource;
import com.event.scheduler.model.Room;
import com.event.scheduler.service.BookingService;
import com.event.scheduler.util.DBConnection;

public class BookingServiceImpl
        implements BookingService {

	private final BookingDAO bookingDAO;
	private final RoomDAO roomDAO;
	private final BookingResourceDAO bookingResourceDAO;

	public BookingServiceImpl() {

	    this.bookingDAO = new BookingDAOImpl();
	    this.roomDAO = new RoomDAOImpl();
	    this.bookingResourceDAO =
	            new BookingResourceDAOImpl();
	}

    @Override
    public boolean createBooking(Booking booking) {

        // -----------------------------------------
        // 1. Basic validation
        // -----------------------------------------

        if ((booking == null) || (booking.getRoomId() <= 0) || (booking.getUserId() <= 0)) {
            return false;
        }

        if (booking.getStartTime() == null ||
                booking.getEndTime() == null || !booking.getEndTime()
                .isAfter(booking.getStartTime()) || (booking.getAttendeeCount() <= 0)) {
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
    public boolean createBooking(
            Booking booking,
            List<BookingResource> bookingResources) {

        // -----------------------------------------
        // 1. Basic booking validation
        // -----------------------------------------

        if ((booking == null) || booking.getRoomId() <= 0 ||
                booking.getUserId() <= 0) {

            return false;
        }

        if (booking.getStartTime() == null ||
                booking.getEndTime() == null || !booking.getEndTime()
                .isAfter(booking.getStartTime()) || (booking.getAttendeeCount() <= 0)) {
            return false;
        }

        // -----------------------------------------
        // 2. Check room
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

        if (!bookingDAO.isRoomAvailable(
                booking.getRoomId(),
                booking.getStartTime(),
                booking.getEndTime())) {

            return false;
        }

        // -----------------------------------------
        // 6. Validate selected resources
        // -----------------------------------------

        if (bookingResources != null) {

            for (BookingResource bookingResource
                    : bookingResources) {

                if (bookingResource == null) {
                    return false;
                }

                if (bookingResource.getResourceId()
                        <= 0) {

                    return false;
                }

                if (bookingResource.getQuantity()
                        <= 0) {

                    return false;
                }

                boolean resourceAvailable =
                        bookingResourceDAO
                        .isResourceAvailable(
                                bookingResource
                                    .getResourceId(),
                                bookingResource
                                    .getQuantity(),
                                booking.getStartTime(),
                                booking.getEndTime());

                if (!resourceAvailable) {
                    return false;
                }
            }
        }

        // -----------------------------------------
        // 7. Set booking status
        // -----------------------------------------

        booking.setStatus("PENDING");

        // -----------------------------------------
        // 8. Start transaction
        // -----------------------------------------

        try (Connection connection =
                DBConnection.getConnection()) {

            connection.setAutoCommit(false);

            try {

                // ---------------------------------
                // 9. Create booking
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
                // 10. Set generated booking ID
                // ---------------------------------

                booking.setBookingId(bookingId);

                // ---------------------------------
                // 11. Attach resources
                // ---------------------------------

                if (bookingResources != null &&
                        !bookingResources.isEmpty()) {

                    for (BookingResource bookingResource
                            : bookingResources) {

                        bookingResource.setBookingId(
                                bookingId);
                    }

                    boolean resourcesAdded =
                            bookingResourceDAO
                            .addBookingResources(
                                    bookingResources,
                                    connection);

                    if (!resourcesAdded) {

                        connection.rollback();

                        return false;
                    }
                }

                // ---------------------------------
                // 12. Everything successful
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

        // Get the booking
        Booking booking =
                bookingDAO.getBookingById(bookingId);

        // Booking must exist
        // Only PENDING or CONFIRMED bookings
        // can be cancelled
        if ((booking == null) || (!"PENDING".equalsIgnoreCase(
                booking.getStatus())
    &&
                !"CONFIRMED".equalsIgnoreCase(
                        booking.getStatus()))) {

            return false;
        }

        // Cancel the booking
        return bookingDAO.cancelBooking(bookingId);
    }

    @Override
    public boolean isRoomAvailable(
            int roomId,
            LocalDateTime startTime,
            LocalDateTime endTime) {

        if (roomId <= 0 ||
                startTime == null ||
                endTime == null || !endTime.isAfter(startTime)) {
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

    @Override
    public boolean approveBooking(int bookingId) {

        // Get the booking
        Booking booking =
                bookingDAO.getBookingById(bookingId);

        // Booking must exist
        // Only PENDING bookings can be approved
        if ((booking == null) || !"PENDING".equalsIgnoreCase(
                booking.getStatus())) {

            return false;
        }

        // Recheck room availability
        boolean roomAvailable =
                bookingDAO.isRoomAvailable(
                        booking.getRoomId(),
                        booking.getStartTime(),
                        booking.getEndTime());

        if (!roomAvailable) {
            return false;
        }

        // Get resources associated with this booking
        List<BookingResource> bookingResources =
                bookingResourceDAO.getResourcesByBooking(
                        bookingId);

        // Recheck resource availability
        if (bookingResources != null) {

            for (BookingResource bookingResource
                    : bookingResources) {

                boolean resourceAvailable =
                        bookingResourceDAO.isResourceAvailable(
                                bookingResource.getResourceId(),
                                bookingResource.getQuantity(),
                                booking.getStartTime(),
                                booking.getEndTime());

                if (!resourceAvailable) {
                    return false;
                }
            }
        }

        // Everything is available
        return bookingDAO.updateBookingStatus(
                bookingId,
                "CONFIRMED");

    }

    @Override
    public void cleanupExpiredBookings() {

        List<Booking> expiredBookings =
                bookingDAO.getExpiredPendingBookings();

        if (expiredBookings == null ||
                expiredBookings.isEmpty()) {

            return;
        }

        for (Booking booking : expiredBookings) {

            bookingDAO.markBookingAsExpired(
                    booking.getBookingId());
        }
    }

    @Override
    public List<Booking> getBookingsByDate(LocalDate date) {

        if (date == null) {
            return new ArrayList<>();
        }

        return bookingDAO.getBookingsByDate(date);
    }


}