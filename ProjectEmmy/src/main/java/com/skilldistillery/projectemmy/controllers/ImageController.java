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
import org.springframework.web.bind.annotation.RequestBody;
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
	
	@PostMapping("images")
	public Image create(@RequestBody Image newImage, HttpServletRequest req, HttpServletResponse res) {
		try {
			newImage = imageSvc.create(newImage);
			res.setStatus(201);
			StringBuffer url = req.getRequestURL();
			url.append("/").append(newImage.getId());
			res.setHeader("Location", url.toString());
		} catch (Exception e) {
			System.err.println(e);
			res.setStatus(400);
			newImage = null;
		}
		return newImage;
	}
	
	@DeleteMapping("images/{imageId}")
	public void destroy(@PathVariable int imageId, HttpServletRequest req, HttpServletResponse res) {
		
	if(imageSvc.getById(imageId) == null) {
		res.setStatus(404);
	}

	try {
		if(imageSvc.destroy(imageId)) {
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
