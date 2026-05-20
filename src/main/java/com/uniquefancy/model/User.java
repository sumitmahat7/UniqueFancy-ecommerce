package com.uniquefancy.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class User implements Serializable {
    private static final long serialVersionUID = 1L;

    private int userId;
    private String fullName;
    private String email;
    private String phone;
    private String password;
    private String role;
    private String address;
    private Timestamp createdAt;
    private Timestamp lastLogin;
    // Default constructor
    public User() {}

    // Constructor with essential fields
    public User(String fullName, String email, String phone, String password) {
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.role = "user";
    }

    // Full constructor
    public User(int userId, String fullName, String email, String phone,
                String password, String role, String address, Timestamp createdAt) {
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.role = role;
        this.address = address;
        this.createdAt = createdAt;
    }

    // Getters
    public int getUserId() { return userId; }
    public String getFullName() { return fullName; }
    public String getEmail() { return email; }
    public String getPhone() { return phone; }
    public String getPassword() { return password; }
    public String getRole() { return role; }
    public String getAddress() { return address; }
    public Timestamp getCreatedAt() { return createdAt; }
    public Timestamp getLastLogin() { return lastLogin; }

    // Setters
    public void setUserId(int userId) { this.userId = userId; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public void setEmail(String email) { this.email = email; }
    public void setPhone(String phone) { this.phone = phone; }
    public void setPassword(String password) { this.password = password; }
    public void setRole(String role) { this.role = role; }
    public void setAddress(String address) { this.address = address; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    public void setLastLogin(Timestamp lastLogin) { this.lastLogin = lastLogin; }

    // Helper methods
    public boolean isAdmin() {
        return "admin".equals(role);
    }

    public boolean isUser() {
        return "user".equals(role);
    }

    @Override
    public String toString() {
        return "User{id=" + userId + ", name=" + fullName + ", email=" + email + ", role=" + role + "}";
    }
}