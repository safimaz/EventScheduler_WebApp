package com.event.scheduler.service;

import java.time.LocalDateTime;
import java.util.List;

import com.event.scheduler.model.Booking;

public interface BookingService {

    boolean createBooking(Booking booking);

    Booking getBookingById(int bookingId);

    List<Booking> getAllBookings();

    List<Booking> getBookingsByUser(int userId);

    List<Booking> getBookingsByRoom(int roomId);

    List<Booking> getBookingsByStatus(String status);

    boolean updateBookingStatus(int bookingId, String status);

    boolean cancelBooking(int bookingId);

    boolean isRoomAvailable(int roomId,
                            LocalDateTime startTime,
                            LocalDateTime endTime);

    List<Booking> getExpiredPendingBookings();

    boolean markBookingAsExpired(int bookingId);
}