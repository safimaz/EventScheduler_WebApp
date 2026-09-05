package com.event.scheduler.dao;

import java.time.LocalDateTime;
import java.util.List;

import com.event.scheduler.model.BookingResource;

public interface BookingResourceDAO {

//	Attach one resource to a booking
    boolean addBookingResource(
            BookingResource bookingResource);

//  Attach multiple resources
    boolean addBookingResources(
            List<BookingResource> bookingResources);

//  Find resources used by a booking
    List<BookingResource> getResourcesByBooking(
            int bookingId);

//  Find bookings using a resource
    List<BookingResource> getBookingsByResource(
            int resourceId);

//  Remove all resources from a booking
    boolean deleteBookingResources(
            int bookingId);

//  Remove one resource from a booking
    boolean deleteBookingResource(
            int bookingId,
            int resourceId);

//  Check whether enough resource quantity is available 
    boolean isResourceAvailable(
            int resourceId,
            int quantity,
            LocalDateTime startTime,
            LocalDateTime endTime);
}