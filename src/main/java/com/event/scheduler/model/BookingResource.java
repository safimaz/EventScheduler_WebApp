package com.event.scheduler.model;

public class BookingResource {

    private int bookingId;
    private int resourceId;
    private int quantity;

    public BookingResource() {
    }

    public BookingResource(int bookingId,
                           int resourceId,
                           int quantity) {
        this.bookingId = bookingId;
        this.resourceId = resourceId;
        this.quantity = quantity;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getResourceId() {
        return resourceId;
    }

    public void setResourceId(int resourceId) {
        this.resourceId = resourceId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "BookingResource{" +
                "bookingId=" + bookingId +
                ", resourceId=" + resourceId +
                ", quantity=" + quantity +
                '}';
    }
}