package com.event.scheduler.service.impl;

import java.util.List;

import com.event.scheduler.dao.ResourceDAO;
import com.event.scheduler.dao.impl.ResourceDAOImpl;
import com.event.scheduler.model.Resource;
import com.event.scheduler.service.ResourceService;

public class ResourceServiceImpl implements ResourceService {

    private final ResourceDAO resourceDAO;

    public ResourceServiceImpl() {
        this.resourceDAO = new ResourceDAOImpl();
    }

    @Override
    public boolean addResource(Resource resource) {
        return resourceDAO.addResource(resource);
    }

    @Override
    public Resource getResourceById(int resourceId) {
        return resourceDAO.getResourceById(resourceId);
    }

    @Override
    public List<Resource> getAllResources() {
        return resourceDAO.getAllResources();
    }

    @Override
    public List<Resource> getAvailableResources() {
        return resourceDAO.getAvailableResources();
    }

    @Override
    public List<Resource> searchResources(String keyword) {
        return resourceDAO.searchResources(keyword);
    }

    @Override
    public boolean updateResource(Resource resource) {
        return resourceDAO.updateResource(resource);
    }

    @Override
    public boolean deleteResource(int resourceId) {
        return resourceDAO.deleteResource(resourceId);
    }
}