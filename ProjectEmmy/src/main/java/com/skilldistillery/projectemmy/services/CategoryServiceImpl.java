package com.skilldistillery.projectemmy.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.projectemmy.entities.Category;
import com.skilldistillery.projectemmy.repositories.CategoryRepository;

@Service
public class CategoryServiceImpl implements CategoryService {

	@Autowired
	private CategoryRepository catRepo;
	
	@Override
	public List<Category> index() {
		return catRepo.findAll();
	}

}
