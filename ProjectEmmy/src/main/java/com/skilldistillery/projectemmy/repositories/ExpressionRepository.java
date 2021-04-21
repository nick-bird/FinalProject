package com.skilldistillery.projectemmy.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.projectemmy.entities.Expression;

public interface ExpressionRepository extends JpaRepository<Expression, Integer> {

	List<Expression> findByUser_Username(String username);
	Expression findByIdAndUser_Username(int eid,String username);
	
}
