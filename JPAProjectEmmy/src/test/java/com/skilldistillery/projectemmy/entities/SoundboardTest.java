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

class SoundboardTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Soundboard soundboard;
	
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
		soundboard = em.find(Soundboard.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		soundboard = null;
	}

	@Test
	@DisplayName("Stub soundboard mapping test")
	void test() {
		assertNotNull(soundboard);
		assertEquals("ASL Signs", soundboard.getName());
	}
	
	@Test
	@DisplayName("Soundboard - soundboard_expression mapping")
	void test2() {
		assertNotNull(soundboard);
		assertEquals("More", soundboard.getSoundboardExpressions().get(0).getExpression().getName());
	}
	
	@Test
	@DisplayName("Soundboard - user mapping")
	void test3() {
		assertNotNull(soundboard);
		assertEquals("admin", soundboard.getUser().getUsername());
	}

}
