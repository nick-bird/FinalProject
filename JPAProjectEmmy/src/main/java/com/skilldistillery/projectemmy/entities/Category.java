package com.skilldistillery.projectemmy.entities;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class Category {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@JsonIgnore
	@ManyToMany(mappedBy="categories")
	private List<Soundboard> soundboards;
	
	private String name;
	
	private String description;
	
	public Category() {}
	
	public Category(int id, List<Soundboard> soundboards, String name, String description) {
		super();
		this.id = id;
		this.soundboards = soundboards;
		this.name = name;
		this.description = description;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public List<Soundboard> getSoundboards() {
		return soundboards;
	}

	public void setSoundboards(List<Soundboard> soundboards) {
		this.soundboards = soundboards;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Category other = (Category) obj;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Category [id=" + id + ", soundboards=" + soundboards + ", name=" + name + ", description=" + description
				+ "]";
	}

}