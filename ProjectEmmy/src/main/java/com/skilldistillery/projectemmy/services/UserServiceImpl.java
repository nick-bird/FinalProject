package com.skilldistillery.projectemmy.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.projectemmy.entities.User;
import com.skilldistillery.projectemmy.repositories.UserRepository;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserRepository userRepo;
	
	
	@Override
	public User updateUserCollections(User user) {

		userRepo.saveAndFlush(user);
		return user;
	}



	
}
