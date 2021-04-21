package com.skilldistillery.projectemmy.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.projectemmy.entities.Image;
import com.skilldistillery.projectemmy.services.ImageService;

@CrossOrigin({"*", "http://localhost:4290"})
@RestController
@RequestMapping("api")
public class ImageController {

	@Autowired
	private ImageService imageSvc;
	
	@GetMapping("images")
	public List<Image> index(){
		return imageSvc.index();
	}
	
	
	
}
