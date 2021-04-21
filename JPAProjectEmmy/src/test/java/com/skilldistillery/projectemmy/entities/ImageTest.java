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

class ImageTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Image image;
	
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
		image = em.find(Image.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		image = null;
	}

	@Test
	@DisplayName("Stub Image mapping test")
	void test() {
		assertNotNull(image);
		assertEquals("https://i.pinimg.com/originals/5c/d1/c4/5cd1c48588d9a83f16cbddbbcb2bfaad.png", image.getImageUrl());
	}

}
