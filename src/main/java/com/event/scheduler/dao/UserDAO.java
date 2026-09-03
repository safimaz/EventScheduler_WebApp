package com.event.scheduler.dao;

import java.util.List;

import com.event.scheduler.model.User;

public interface UserDAO {

    boolean addUser(User user);

    User getUserById(int userId);

    User getUserByEmail(String email);

    List<User> getAllUsers();

    boolean updateUser(User user);

    boolean deleteUser(int userId);

    boolean validateLogin(String email, String password);
}

//
//| Method             | Purpose                              |
//| ------------------ | ------------------------------------ |
//| `addUser()`        | Add a new user to `USERS`            |
//| `getUserById()`    | Find a user by ID                    |
//| `getUserByEmail()` | Find a user using email              |
//| `getAllUsers()`    | Retrieve all users                   |
//| `updateUser()`     | Update user information              |
//| `deleteUser()`     | Delete/deactivate a user             |
//| `validateLogin()`  | Verify email + password during login |
