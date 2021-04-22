package com.skilldistillery.projectemmy.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.projectemmy.entities.Image;
import com.skilldistillery.projectemmy.repositories.ImageRepository;
import com.skilldistillery.projectemmy.repositories.UserRepository;
@Service
public class ImageServiceImpl implements ImageService {
	
	@Autowired
	private ImageRepository imageRepo;
	
	
	@Override
	public List<Image> index() {
	return imageRepo.findAll();
	}

	@Override
	public Image create(Image newImage) {
	return imageRepo.saveAndFlush(newImage);
		
	}

	@Override
	public boolean destroy(int imageId) {
		
		if (imageRepo.existsById(imageId)) {
		imageRepo.deleteById(imageId);
		
		if(imageRepo.existsById(imageId)) {
			return false;
		}
		
		return true;
		}
		return false;
	}

	@Override
	public Image getById(int imageId) {
		Image image = null;
		try {
			image = imageRepo.getOne(imageId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return image;
	}

}
