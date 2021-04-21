package com.skilldistillery.projectemmy.services;

import java.util.List;

import com.skilldistillery.projectemmy.entities.Soundboard;

public interface SoundboardService {

	public List<Soundboard> index(String username);

    public Soundboard show(String username, int sid);

    public Soundboard create(String username, Soundboard soundboard);

    public Soundboard update(String username, int sid, Soundboard soundboard);

    public boolean destroy(String username, int eid);
	
	
}
