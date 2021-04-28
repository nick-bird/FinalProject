package com.skilldistillery.projectemmy.services;

import com.skilldistillery.projectemmy.entities.User;

public interface AuthService {
	
	public User register(User user);
	
	public User deactivate(User user);
	
	public User reactivate(User user);
	
	public User getUser(String username);
	
	public User findById(int id);
	
	
}
