package com.skilldistillery.projectemmy.controllers;

import java.security.Principal;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.projectemmy.entities.User;
import com.skilldistillery.projectemmy.services.AuthService;

@CrossOrigin({ "*", "http://localhost:4290" })
@RestController
public class AuthController {
	
	@Autowired
	private AuthService authService;
	
	@RequestMapping(path = "/register", method = RequestMethod.POST)
	public User register(@RequestBody User user, HttpServletResponse res) {
		
		if (user == null) {
	        res.setStatus(400);
	    }
		
		user = authService.register(user);
		
		return user;
	}
	
	@RequestMapping(path = "/authenticate", method = RequestMethod.GET)
	public Principal authenticate(Principal principal) {
	    return principal;
	}
	@PutMapping("deactivate/{uid}")
	public User deactivate(@PathVariable int uid, @RequestBody 
			User user) {
		//User managedUser = authService.findById(uid);
		authService.deactivate(user);
		return user;
		
	}
	
	
	
// FIXME?	
//	@PutMapping("/reactivate")
//	public User reactivate(Principal principal) {
//		User managedUser = authService.getUser(principal.getName());
//		authService.reactivate(managedUser);
//		return managedUser;
//		
//	}
}
