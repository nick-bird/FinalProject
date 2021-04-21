package com.skilldistillery.projectemmy.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.projectemmy.entities.Soundboard;

public interface SoundboardRepository extends JpaRepository<Soundboard, Integer> {

	List<Soundboard> findByUser_Username(String username);
	Soundboard findByIdAndUser_Username(int sid,String username);
	
}
