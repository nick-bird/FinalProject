package com.skilldistillery.projectemmy.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.projectemmy.entities.Soundboard;
import com.skilldistillery.projectemmy.entities.SoundboardExpression;
import com.skilldistillery.projectemmy.entities.SoundboardExpressionId;
import com.skilldistillery.projectemmy.entities.User;
import com.skilldistillery.projectemmy.repositories.SoundboardExpressionRepository;
import com.skilldistillery.projectemmy.repositories.SoundboardRepository;
import com.skilldistillery.projectemmy.repositories.UserRepository;

@Service
public class SoundboardServiceImpl implements SoundboardService {

	@Autowired
	private SoundboardRepository soundRepo;
	
	@Autowired
	private UserRepository userRepo;
	
	@Autowired
	private SoundboardExpressionRepository sExpRepo;
	
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
			if(soundboard.getIsPublic() == null) {
				soundboard.setIsPublic(false);
			}
			soundRepo.saveAndFlush(soundboard);
			if(soundboard.getSoundboardExpressions() != null) {
				for (SoundboardExpression exp : soundboard.getSoundboardExpressions()) {
					exp.setSoundboard(soundboard);
					SoundboardExpressionId  id = new SoundboardExpressionId(soundboard.getId(),exp.getExpression().getId()); 
					exp.setId(id);
				
					sExpRepo.saveAndFlush(exp);
				}
			}
		}
		return soundboard;
	}

	@Override
	public Soundboard update(String username, int sid, Soundboard soundboard) {
		Soundboard managedSoundboard = show(username, sid);

		if (managedSoundboard != null) {
			List<SoundboardExpression> soundExp = managedSoundboard.getSoundboardExpressions();
			soundExp.clear();
			for (SoundboardExpression exp : soundboard.getSoundboardExpressions()) {
				exp.setSoundboard(managedSoundboard);
				soundExp.add(exp);
				SoundboardExpressionId  id = new SoundboardExpressionId(sid,exp.getExpression().getId()); 
				exp.setId(id);
				sExpRepo.saveAndFlush(exp);
			}
			System.out.println(soundboard.getSoundboardExpressions());
			System.out.println(managedSoundboard.getSoundboardExpressions());
			managedSoundboard.setName(soundboard.getName());
			managedSoundboard.setIsPublic(soundboard.getIsPublic());
			managedSoundboard.setDescription(soundboard.getDescription());
			managedSoundboard.setCategories(soundboard.getCategories());
//			managedSoundboard.getSoundboardExpressions().addAll(soundboard.getSoundboardExpressions());
//			managedSoundboard.setSoundboardExpressions(soundboard.getSoundboardExpressions());;
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
