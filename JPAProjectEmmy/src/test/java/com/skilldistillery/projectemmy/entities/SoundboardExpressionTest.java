package com.skilldistillery.projectemmy.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class SoundboardExpressionTest {

		private static EntityManagerFactory emf;
		private EntityManager em;
		private SoundboardExpression soundboardExp;
		
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
			SoundboardExpressionId sid = new SoundboardExpressionId();
			sid.setExpressionId(1);
			sid.setSoundboardId(1);
			soundboardExp = em.find(SoundboardExpression.class, new SoundboardExpressionId(1, 1));
		}

		@AfterEach
		void tearDown() throws Exception {
			em.close();
			soundboardExp = null;
		}

		@Test
		@DisplayName("Composite primary key test")
		void test() {
			assertNotNull(soundboardExp);
			assertEquals(1, soundboardExp.getPositionId());
		}

	}