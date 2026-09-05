package com.event.scheduler.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.event.scheduler.dao.ResourceDAO;
import com.event.scheduler.model.Resource;
import com.event.scheduler.util.DBConnection;

public class ResourceDAOImpl implements ResourceDAO {

    @Override
    public boolean addResource(Resource resource) {

        String sql = "INSERT INTO resources "
                + "(resource_name, resource_type, quantity, status) "
                + "VALUES (?, ?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, resource.getResourceName());
            statement.setString(2, resource.getResourceType());
            statement.setInt(3, resource.getQuantity());
            statement.setString(4, resource.getStatus());

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public Resource getResourceById(int resourceId) {

        String sql = "SELECT resource_id, resource_name, "
                + "resource_type, quantity, status "
                + "FROM resources WHERE resource_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, resourceId);

            try (ResultSet resultSet = statement.executeQuery()) {

                if (resultSet.next()) {
                    return mapResource(resultSet);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public List<Resource> getAllResources() {

        List<Resource> resources = new ArrayList<>();

        String sql = "SELECT resource_id, resource_name, "
                + "resource_type, quantity, status "
                + "FROM resources ORDER BY resource_id";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                resources.add(mapResource(resultSet));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return resources;
    }

    @Override
    public List<Resource> getAvailableResources() {

        List<Resource> resources = new ArrayList<>();

        String sql = "SELECT resource_id, resource_name, "
                + "resource_type, quantity, status "
                + "FROM resources "
                + "WHERE status = 'AVAILABLE' "
                + "ORDER BY resource_id";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                resources.add(mapResource(resultSet));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return resources;
    }

    @Override
    public List<Resource> searchResources(String keyword) {

        List<Resource> resources = new ArrayList<>();

        String sql = "SELECT resource_id, resource_name, "
                + "resource_type, quantity, status "
                + "FROM resources "
                + "WHERE LOWER(resource_name) LIKE ? "
                + "OR LOWER(resource_type) LIKE ? "
                + "ORDER BY resource_id";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            String searchKeyword =
                    "%" + keyword.toLowerCase() + "%";

            statement.setString(1, searchKeyword);
            statement.setString(2, searchKeyword);

            try (ResultSet resultSet = statement.executeQuery()) {

                while (resultSet.next()) {
                    resources.add(mapResource(resultSet));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return resources;
    }

    @Override
    public boolean updateResource(Resource resource) {

        String sql = "UPDATE resources SET "
                + "resource_name = ?, "
                + "resource_type = ?, "
                + "quantity = ?, "
                + "status = ? "
                + "WHERE resource_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, resource.getResourceName());
            statement.setString(2, resource.getResourceType());
            statement.setInt(3, resource.getQuantity());
            statement.setString(4, resource.getStatus());
            statement.setInt(5, resource.getResourceId());

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteResource(int resourceId) {

        String sql = "DELETE FROM resources WHERE resource_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, resourceId);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private Resource mapResource(ResultSet resultSet)
            throws Exception {

        Resource resource = new Resource();

        resource.setResourceId(
                resultSet.getInt("resource_id"));

        resource.setResourceName(
                resultSet.getString("resource_name"));

        resource.setResourceType(
                resultSet.getString("resource_type"));

        resource.setQuantity(
                resultSet.getInt("quantity"));

        resource.setStatus(
                resultSet.getString("status"));

        return resource;
    }
}