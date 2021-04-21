package com.skilldistillery.projectemmy.entities;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class ExpressionTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Expression expression;
	
	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("ProjectEmmyPU");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		expression = em.find(Expression.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		expression = null;
	}

	@Test
	@DisplayName("Stub Expression mapping test")
	void test() {
		assertNotNull(expression);
		assertEquals("More", expression.getName());
	}
	
	@Test
	@DisplayName("Expression - Image relationship mapping test")
	void test2() {
		assertNotNull(expression);
		assertEquals("https://i.pinimg.com/originals/5c/d1/c4/5cd1c48588d9a83f16cbddbbcb2bfaad.png", expression.getImage().getImageUrl());
	}
	
	@Test
	@DisplayName("Expression - User relationship mapping test")
	void test3() {
		assertNotNull(expression);
		assertEquals("admin", expression.getUser().getFirstName());
	}

}