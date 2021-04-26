package com.skilldistillery.projectemmy.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.projectemmy.entities.Soundboard;
import com.skilldistillery.projectemmy.entities.User;
import com.skilldistillery.projectemmy.repositories.SoundboardRepository;
import com.skilldistillery.projectemmy.repositories.UserRepository;

@Service
public class SoundboardServiceImpl implements SoundboardService {

	@Autowired
	private SoundboardRepository soundRepo;
	
	@Autowired
	private UserRepository userRepo;
	
	@Override
	public List<Soundboard> index(String username) {
		return soundRepo.findByUser_Username(username);
		
	}

	@Override
	public Soundboard create(String username, Soundboard soundboard) {
		User user = userRepo.findByUsername(username);
		if(user != null) {
			soundboard.setUser(user);
			soundboard.setIsDefault(false);
			System.out.println(soundboard.getSoundboardExpressions());
			soundRepo.saveAndFlush(soundboard);
		}
		return soundboard;
	}

	@Override
	public Soundboard update(String username, int sid, Soundboard soundboard) {
		Soundboard managedSoundboard = show(username, sid);

		if (managedSoundboard != null) {
			
			System.out.println(soundboard.getSoundboardExpressions());
			managedSoundboard.setName(soundboard.getName());
			managedSoundboard.setIsPublic(soundboard.getIsPublic());
			managedSoundboard.setDescription(soundboard.getDescription());
			managedSoundboard.setCategories(soundboard.getCategories());
			managedSoundboard.getSoundboardExpressions().addAll(soundboard.getSoundboardExpressions());
			soundRepo.saveAndFlush(managedSoundboard);
			return managedSoundboard;
		}

		return null;
	}

	@Override
	public boolean destroy(String username, int sid) {
		boolean soundboardWasDeleted = false;

		Soundboard soundboard = show(username, sid);
		
		if(soundboard != null) {
			
			soundRepo.deleteById(sid);
			soundboardWasDeleted = true;
		}


		return soundboardWasDeleted;
	}

	@Override
	public Soundboard show(String username, int sid) {
		return soundRepo.findByIdAndUser_Username(sid, username);
	}

	@Override
	public List<Soundboard> publicSoundboards() {
		return soundRepo.findByIsPublicTrue();
	}

}
