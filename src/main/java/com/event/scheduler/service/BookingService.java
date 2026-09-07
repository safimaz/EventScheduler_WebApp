package com.event.scheduler.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import com.event.scheduler.model.Booking;
import com.event.scheduler.model.BookingResource;

public interface BookingService {

    boolean createBooking(Booking booking);

    boolean createBooking(
            Booking booking,
            List<BookingResource> bookingResources);

    Booking getBookingById(int bookingId);

    List<Booking> getAllBookings();

    List<Booking> getBookingsByUser(int userId);

    List<Booking> getBookingsByRoom(int roomId);

    List<Booking> getBookingsByStatus(String status);

    boolean updateBookingStatus(
            int bookingId,
            String status);

    boolean cancelBooking(int bookingId);

    boolean isRoomAvailable(
            int roomId,
            LocalDateTime startTime,
            LocalDateTime endTime);

    List<Booking> getExpiredPendingBookings();

    boolean markBookingAsExpired(int bookingId);

    boolean approveBooking(int bookingId);
    
    void cleanupExpiredBookings();
    
    List<Booking> getBookingsByDate(LocalDate date);
    
}