package com.event.scheduler.service.impl;

import java.util.List;

import com.event.scheduler.dao.UserDAO;
import com.event.scheduler.dao.impl.UserDAOImpl;
import com.event.scheduler.model.User;
import com.event.scheduler.service.UserService;

public class UserServiceImpl implements UserService {

    private final UserDAO userDAO;

    public UserServiceImpl() {
        this.userDAO = new UserDAOImpl();
    }

    @Override
    public boolean addUser(User user) {
        return userDAO.addUser(user);
    }

    @Override
    public User getUserById(int userId) {
        return userDAO.getUserById(userId);
    }

    @Override
    public User getUserByEmail(String email) {
        return userDAO.getUserByEmail(email);
    }

    @Override
    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }

    @Override
    public boolean updateUser(User user) {
        return userDAO.updateUser(user);
    }

    @Override
    public boolean deleteUser(int userId) {
        return userDAO.deleteUser(userId);
    }

    @Override
    public boolean validateLogin(String email, String password) {
    	
    	// Validate email
        if (email == null || email.trim().isEmpty()) {
            return false;
        }

        // Validate password
        if (password == null || password.trim().isEmpty()) {
            return false;
        }

    	
        return userDAO.validateLogin(email, password);
    }
}