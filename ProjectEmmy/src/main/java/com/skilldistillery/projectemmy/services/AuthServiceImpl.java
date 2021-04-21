package com.skilldistillery.projectemmy.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.skilldistillery.projectemmy.entities.User;
import com.skilldistillery.projectemmy.repositories.UserRepository;

public class AuthServiceImpl implements AuthService {

	@Autowired
	private PasswordEncoder encoder;
	
	@Autowired
	private UserRepository userRepo;
	
	@Override
	public User register(User user) {
		String encodedPW = encoder.encode(user.getPassword());
		user.setPassword(encodedPW); // only persist encoded password

		// set other fields to default values
		user.setRole("standard");
		user.setEnabled(true);
		

		userRepo.saveAndFlush(user);
		return user;
	}

}
