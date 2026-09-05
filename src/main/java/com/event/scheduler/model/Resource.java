package com.event.scheduler.model;

public class Resource {

    private int resourceId;
    private String resourceName;
    private String resourceType;
    private int quantity;
    private String status;

    // Default constructor
    public Resource() {
    }

    // Constructor without resourceId
    public Resource(String resourceName, String resourceType,
                    int quantity, String status) {

        this.resourceName = resourceName;
        this.resourceType = resourceType;
        this.quantity = quantity;
        this.status = status;
    }

    // Full constructor
    public Resource(int resourceId, String resourceName,
                    String resourceType, int quantity,
                    String status) {

        this.resourceId = resourceId;
        this.resourceName = resourceName;
        this.resourceType = resourceType;
        this.quantity = quantity;
        this.status = status;
    }

    public int getResourceId() {
        return resourceId;
    }

    public void setResourceId(int resourceId) {
        this.resourceId = resourceId;
    }

    public String getResourceName() {
        return resourceName;
    }

    public void setResourceName(String resourceName) {
        this.resourceName = resourceName;
    }

    public String getResourceType() {
        return resourceType;
    }

    public void setResourceType(String resourceType) {
        this.resourceType = resourceType;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Resource{" +
                "resourceId=" + resourceId +
                ", resourceName='" + resourceName + '\'' +
                ", resourceType='" + resourceType + '\'' +
                ", quantity=" + quantity +
                ", status='" + status + '\'' +
                '}';
    }
}