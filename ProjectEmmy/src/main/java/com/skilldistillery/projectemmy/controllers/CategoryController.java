package com.skilldistillery.projectemmy.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.projectemmy.entities.Category;
import com.skilldistillery.projectemmy.services.CategoryService;

@CrossOrigin({"*", "http://localhost:4290"})
@RequestMapping("api")
@RestController
public class CategoryController {

	
	
	@Autowired
	private CategoryService catSvc;
	
	
	@GetMapping("categories")
	public List<Category> index() { 	
		return catSvc.index();
	}

	
	
}
