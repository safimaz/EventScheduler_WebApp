package com.event.scheduler.service.impl;

import java.time.LocalDateTime;
import java.util.List;

import com.event.scheduler.dao.BookingResourceDAO;
import com.event.scheduler.dao.impl.BookingResourceDAOImpl;
import com.event.scheduler.model.BookingResource;
import com.event.scheduler.service.BookingResourceService;

public class BookingResourceServiceImpl
        implements BookingResourceService {

    private final BookingResourceDAO bookingResourceDAO;

    public BookingResourceServiceImpl() {
        this.bookingResourceDAO =
                new BookingResourceDAOImpl();
    }

    @Override
    public boolean addBookingResource(
            BookingResource bookingResource) {

        return bookingResourceDAO
                .addBookingResource(bookingResource);
    }

    @Override
    public boolean addBookingResources(
            List<BookingResource> bookingResources) {

        return bookingResourceDAO
                .addBookingResources(bookingResources);
    }

    @Override
    public List<BookingResource> getResourcesByBooking(
            int bookingId) {

        return bookingResourceDAO
                .getResourcesByBooking(bookingId);
    }

    @Override
    public List<BookingResource> getBookingsByResource(
            int resourceId) {

        return bookingResourceDAO
                .getBookingsByResource(resourceId);
    }

    @Override
    public boolean deleteBookingResources(
            int bookingId) {

        return bookingResourceDAO
                .deleteBookingResources(bookingId);
    }

    @Override
    public boolean deleteBookingResource(
            int bookingId,
            int resourceId) {

        return bookingResourceDAO
                .deleteBookingResource(
                        bookingId,
                        resourceId);
    }

    @Override
    public boolean isResourceAvailable(
            int resourceId,
            int quantity,
            LocalDateTime startTime,
            LocalDateTime endTime) {

        return bookingResourceDAO
                .isResourceAvailable(
                        resourceId,
                        quantity,
                        startTime,
                        endTime);
    }
}