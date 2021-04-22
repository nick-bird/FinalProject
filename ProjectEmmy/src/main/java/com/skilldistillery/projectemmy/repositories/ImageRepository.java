package com.skilldistillery.projectemmy.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.projectemmy.entities.Image;

public interface ImageRepository  extends JpaRepository<Image, Integer> {

}
