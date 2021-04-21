package com.skilldistillery.projectemmy.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.projectemmy.entities.Image;
import com.skilldistillery.projectemmy.repositories.ImageRepository;
@Service
public class ImageServiceImpl implements ImageService {
	
	@Autowired
	private ImageRepository imageRepo;
	
	@Override
	public List<Image> index() {
	return imageRepo.findAll();
	}

}
