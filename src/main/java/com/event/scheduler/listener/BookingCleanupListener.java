package com.event.scheduler.listener;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import com.event.scheduler.service.BookingService;
import com.event.scheduler.service.impl.BookingServiceImpl;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener

public class BookingCleanupListener

        implements ServletContextListener {

    private ScheduledExecutorService scheduler;

    private BookingService bookingService;

    @Override

    public void contextInitialized(

            ServletContextEvent event) {

        bookingService =

                new BookingServiceImpl();

        scheduler =

                Executors.newSingleThreadScheduledExecutor();

        scheduler.scheduleAtFixedRate(

                this::cleanupExpiredBookings,

                1,

                1,

                TimeUnit.MINUTES

        );

        System.out.println(

                "Booking Cleanup Scheduler started."

        );

    }

    private void cleanupExpiredBookings() {

        try {

            bookingService.cleanupExpiredBookings();

            System.out.println(
                    "Booking Cleanup completed."
            );

        } catch (Exception e) {

            System.err.println(
                    "Error during booking cleanup."
            );

            e.printStackTrace();
        }
    }



    @Override

    public void contextDestroyed(

            ServletContextEvent event) {

        if (scheduler != null &&

                !scheduler.isShutdown()) {

            scheduler.shutdown();

            System.out.println(

                    "Booking Cleanup Scheduler stopped."

            );

        }

    }

}
