package com.event.scheduler.service.impl;

import java.util.List;

import com.event.scheduler.dao.RoomDAO;
import com.event.scheduler.dao.impl.RoomDAOImpl;
import com.event.scheduler.model.Room;
import com.event.scheduler.service.RoomService;

public class RoomServiceImpl implements RoomService {

    private final RoomDAO roomDAO;

    public RoomServiceImpl() {
        this.roomDAO = new RoomDAOImpl();
    }

    @Override
    public boolean addRoom(Room room) {
        return roomDAO.addRoom(room);
    }

    @Override
    public Room getRoomById(int roomId) {
        return roomDAO.getRoomById(roomId);
    }

    @Override
    public List<Room> getAllRooms() {
        return roomDAO.getAllRooms();
    }

    @Override
    public List<Room> getAvailableRooms() {
        return roomDAO.getAvailableRooms();
    }

    @Override
    public List<Room> searchRooms(String keyword) {
        return roomDAO.searchRooms(keyword);
    }

    @Override
    public boolean updateRoom(Room room) {
        return roomDAO.updateRoom(room);
    }

    @Override
    public boolean deleteRoom(int roomId) {
        return roomDAO.deleteRoom(roomId);
    }
}