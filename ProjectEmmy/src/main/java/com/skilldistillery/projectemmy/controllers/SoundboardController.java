package com.skilldistillery.projectemmy.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.projectemmy.entities.Soundboard;
import com.skilldistillery.projectemmy.services.SoundboardService;

@CrossOrigin({"*", "http://localhost:4290"})
@RequestMapping("api")
@RestController
public class SoundboardController {

	@Autowired
	private SoundboardService soundSvc;
	
	
	@GetMapping("soundboards")
	public List<Soundboard> index(HttpServletRequest req, HttpServletResponse res, Principal principal) { 
		return soundSvc.index(principal.getName());
	}
	
	
	@GetMapping("public/soundboards")
	public List<Soundboard> pSoundboard() { 
		return soundSvc.publicSoundboards();
	}

	@GetMapping("soundboards/{sid}")
	public Soundboard show(HttpServletRequest req, HttpServletResponse res, @PathVariable int sid, Principal principal) {
		Soundboard soundboard = soundSvc.show(principal.getName(), sid);
		
		if(soundboard == null) {
			res.setStatus(404);
		}
		return soundboard;
	}

	
	@PostMapping("soundboards")
	public Soundboard create(HttpServletRequest req, HttpServletResponse res, @RequestBody Soundboard soundboard, Principal principal) {
		try {
			soundboard = soundSvc.create(principal.getName(),soundboard);
			res.setStatus(201);
			StringBuffer url = req.getRequestURL();
			url.append("/").append(soundboard.getId());
			res.setHeader("Location", url.toString());
		} catch (Exception e) {
			System.err.println(e);
			res.setStatus(400);
			soundboard = null;
		}
		return soundboard;
	}

	
	@PutMapping("soundboards/{sid}")
	public Soundboard update(HttpServletRequest req, HttpServletResponse res, @PathVariable int sid,@RequestBody Soundboard soundboard, Principal principal) {
		
		try {
			soundboard = soundSvc.update(principal.getName(),sid,soundboard);
			if (soundboard == null) {
				res.setStatus(404);
			}
		} catch (Exception e) {
			System.err.println(e);
			res.setStatus(400);
			soundboard = null;
		}
		return soundboard;
	}


	@DeleteMapping("soundboards/{sid}")
	public void destroy(HttpServletRequest req, HttpServletResponse res, @PathVariable int sid, Principal principal) {
		
	if(soundSvc.show(principal.getName(), sid) == null) {
		res.setStatus(404);
	}

	try {
		if(soundSvc.destroy(principal.getName(), sid)) {
			res.setStatus(204);
		} else {
			res.setStatus(404);
		}
	} catch (Exception e) {
		System.err.println(e);
		res.setStatus(400);
	}
	}

	
	
}
