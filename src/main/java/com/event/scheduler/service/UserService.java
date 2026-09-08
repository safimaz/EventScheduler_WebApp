package com.event.scheduler.service;

import java.util.List;

import com.event.scheduler.model.User;

public interface UserService {

    boolean addUser(User user);

    User getUserById(int userId);

    List<User> getAllUsers();

    boolean updateUser(User user);

    boolean deleteUser(int userId);
}