package com.skilldistillery.projectemmy.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.projectemmy.entities.SoundboardExpression;
import com.skilldistillery.projectemmy.repositories.SoundboardExpressionRepository;
@Service
public class SoundboardExpressionServiceImpl implements SoundboardExpressionService {

	@Autowired
	private SoundboardExpressionRepository seRepo;
	
	@Override
	public SoundboardExpression create(SoundboardExpression soundboardExpression) {
		return seRepo.saveAndFlush(soundboardExpression);
	}

}
