package com.event.scheduler.dao;

import java.util.List;

import com.event.scheduler.model.Room;

public interface RoomDAO {

    boolean addRoom(Room room);

    Room getRoomById(int roomId);

    List<Room> getAllRooms();

    List<Room> getAvailableRooms();

    List<Room> searchRooms(String keyword);

    boolean updateRoom(Room room);

    boolean deleteRoom(int roomId);
}