package com.skilldistillery.projectemmy.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.projectemmy.entities.Expression;
import com.skilldistillery.projectemmy.entities.User;
import com.skilldistillery.projectemmy.repositories.ExpressionRepository;
import com.skilldistillery.projectemmy.repositories.UserRepository;

@Service
public class ExpressionServiceImpl implements ExpressionService {

	@Autowired
	private ExpressionRepository expRepo;
	
	@Autowired
	private UserRepository userRepo;
	
	@Override
	public List<Expression> index(String username) {
		return expRepo.findByUser_Username(username);
	}

	@Override
	public Expression create(String username, Expression exp) {
		User user = userRepo.findByUsername(username);
		if(user != null) {
			exp.setUser(user);
			expRepo.saveAndFlush(exp);
		}
		return exp;
	}

	@Override
	public Expression update(String username, int eid, Expression exp) {
		Expression managedExp = show(username, eid);

	
		
		if (managedExp != null) {
			
			managedExp.setName(exp.getName());
			managedExp.setPhrase(exp.getPhrase());
			managedExp.getImage().setImageUrl(exp.getImage().getImageUrl());
//			managedExp.setImage(exp.getImage());
			expRepo.saveAndFlush(managedExp);
			return managedExp;
		}

		return null;
	}

	@Override
	public boolean destroy(String username, int eid) {
		boolean expWasDeleted = false;

		Expression exp = show(username, eid);
		
		if(exp != null) {
			
			expRepo.deleteById(eid);
			expWasDeleted = true;
		}


		return expWasDeleted;
	}

	@Override
	public Expression show(String username, int eid) {
		return expRepo.findByIdAndUser_Username(eid, username);
	}

	@Override
	public List<Expression> indexPublic() {
		return expRepo.findAll();
	}

}
