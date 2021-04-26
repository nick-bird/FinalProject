package com.skilldistillery.projectemmy.controllers;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.projectemmy.entities.User;
import com.skilldistillery.projectemmy.services.AuthService;
import com.skilldistillery.projectemmy.services.UserService;

@CrossOrigin({"*", "http://localhost:4290"})
@RequestMapping("api")
@RestController
public class UserController {

	@Autowired
	private UserService userSvc;
	
	@Autowired
	private AuthService authService;
	
	
	@GetMapping("userprofile")
	public User userProfile(Principal principal) {
		return authService.getUser(principal.getName());
	}
	
	
	
}
