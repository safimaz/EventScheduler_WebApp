package com.event.scheduler.service;

import java.time.LocalDateTime;
import java.util.List;

import com.event.scheduler.model.BookingResource;

public interface BookingResourceService {

    boolean addBookingResource(
            BookingResource bookingResource);

    boolean addBookingResources(
            List<BookingResource> bookingResources);

    List<BookingResource> getResourcesByBooking(
            int bookingId);

    List<BookingResource> getBookingsByResource(
            int resourceId);

    boolean deleteBookingResources(int bookingId);

    boolean deleteBookingResource(
            int bookingId,
            int resourceId);

    boolean isResourceAvailable(
            int resourceId,
            int quantity,
            LocalDateTime startTime,
            LocalDateTime endTime);
}