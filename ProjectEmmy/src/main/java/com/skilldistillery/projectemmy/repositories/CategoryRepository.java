package com.skilldistillery.projectemmy.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.projectemmy.entities.Category;

public interface CategoryRepository extends JpaRepository<Category, Integer>{

}
