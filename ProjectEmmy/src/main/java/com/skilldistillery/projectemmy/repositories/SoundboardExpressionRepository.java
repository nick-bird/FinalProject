package com.skilldistillery.projectemmy.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.projectemmy.entities.SoundboardExpression;
import com.skilldistillery.projectemmy.entities.SoundboardExpressionId;

public interface SoundboardExpressionRepository extends JpaRepository<SoundboardExpression, SoundboardExpressionId> {

}
