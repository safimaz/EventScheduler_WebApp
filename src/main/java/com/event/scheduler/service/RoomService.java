package com.event.scheduler.service;

import java.util.List;

import com.event.scheduler.model.Room;

public interface RoomService {

    boolean addRoom(Room room);

    Room getRoomById(int roomId);

    List<Room> getAllRooms();

    List<Room> getAvailableRooms();

    List<Room> searchRooms(String keyword);

    boolean updateRoom(Room room);

    boolean deleteRoom(int roomId);
}