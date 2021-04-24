package com.skilldistillery.projectemmy.controllers;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.projectemmy.entities.SoundboardExpression;
import com.skilldistillery.projectemmy.services.SoundboardExpressionService;

@CrossOrigin({"*", "http://localhost:4290"})
@RequestMapping("api")
@RestController
public class SoundboardExpressionController {

	@Autowired
	private SoundboardExpressionService seSvc;
	
	
	
	//@PostMapping("soundboardexpressions")
	public SoundboardExpression create(HttpServletResponse res, @RequestBody SoundboardExpression soundboardExpression) {
		
		try {
			soundboardExpression = seSvc.create(soundboardExpression);
			res.setStatus(201);
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			soundboardExpression = null;
		}
		
		return soundboardExpression;
		
	}
	
	
	
}
