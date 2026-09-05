package com.event.scheduler.dao;

import java.util.List;

import com.event.scheduler.model.Resource;

public interface ResourceDAO {

    boolean addResource(Resource resource);

    Resource getResourceById(int resourceId);

    List<Resource> getAllResources();

    List<Resource> getAvailableResources();

    List<Resource> searchResources(String keyword);

    boolean updateResource(Resource resource);

    boolean deleteResource(int resourceId);
}