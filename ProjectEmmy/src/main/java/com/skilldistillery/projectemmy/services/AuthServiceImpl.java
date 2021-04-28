package com.skilldistillery.projectemmy.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.skilldistillery.projectemmy.entities.User;
import com.skilldistillery.projectemmy.repositories.UserRepository;

@Service
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
		user.setActive(true);
		

		userRepo.saveAndFlush(user);
		return user;
	}

	@Override
	public User deactivate(User user) {

		user.setActive(false);
		userRepo.saveAndFlush(user);
		return user;
	}
	


	@Override
	public User reactivate(User user) {
		user.setActive(true);
		userRepo.saveAndFlush(user);
		return user;
	}

	@Override
	public User getUser(String username) {

	return	userRepo.findByUsername(username);
		
	}

	@Override
	public User findById(int id) {

		return userRepo.getOne(id);
	}
	
	
	

}
