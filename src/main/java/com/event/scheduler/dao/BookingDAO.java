package com.event.scheduler.dao;

import java.sql.Connection;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import com.event.scheduler.model.Booking;

public interface BookingDAO {

//	create a new booking
    boolean addBooking(Booking booking);

//  creates a booking and return the newly generated booking id
    int addBooking(Booking booking, Connection connection);

//  Find one booking with id
    Booking getBookingById(int bookingId);

//  Find all the bookings
    List<Booking> getAllBookings();

//  Show a user's booking
    List<Booking> getBookingsByUser(int userId);

//  Find booking for a room
    List<Booking> getBookingsByRoom(int roomId);

//  Find PENDING/CONFIRMED
    List<Booking> getBookingsByStatus(String status);

//  APPROVE/REJECT a booking
    boolean updateBookingStatus(int bookingId, String status);

//  Cancel a booking
    boolean cancelBooking(int bookingId);

//  Prevent double booking overlapping
    boolean isRoomAvailable(int roomId,
                            LocalDateTime startTime,
                            LocalDateTime endTime);

//  count overlapping bookings
    int getBookingCountForRoom(int roomId,
                               LocalDateTime startTime,
                               LocalDateTime endTime);

//  Find old unconfirmed bookings
    List<Booking> getExpiredPendingBookings();

//  Change PENDING->EXPIRED
    boolean markBookingAsExpired(int bookingId);
    
//  Retrieve bookings based on specific date
    List<Booking> getBookingsByDate(LocalDate date);
}