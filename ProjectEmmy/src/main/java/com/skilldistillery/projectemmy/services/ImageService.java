package com.skilldistillery.projectemmy.services;

import java.util.List;

import com.skilldistillery.projectemmy.entities.Image;

public interface ImageService {
List<Image> index();
Image create(Image newImage);
boolean destroy(int imageId);
Image getById(int imageId);
}
