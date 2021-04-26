package com.skilldistillery.projectemmy.entities;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class Expression {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	private String phrase;
	
	@JsonIgnore
	@OneToMany(orphanRemoval=true, mappedBy="expression")
	private List<SoundboardExpression> soundboardExpressions;
	
	@JsonIgnore
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	
	@OneToOne
	@JoinColumn(name="image_id")
	private Image image;
	
	public Expression() {
		
	}
	
	public Expression(int id, String name, String phrase, List<SoundboardExpression> soundboardExpressions, User user,
			Image image) {
		super();
		this.id = id;
		this.name = name;
		this.phrase = phrase;
		this.soundboardExpressions = soundboardExpressions;
		this.user = user;
		this.image = image;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhrase() {
		return phrase;
	}

	public void setPhrase(String phrase) {
		this.phrase = phrase;
	}

	public List<SoundboardExpression> getSoundboardExpressions() {
		return soundboardExpressions;
	}

	public void setSoundboardExpressions(List<SoundboardExpression> soundboardExpressions) {
		this.soundboardExpressions = soundboardExpressions;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Image getImage() {
		return image;
	}

	public void setImage(Image image) {
		this.image = image;
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
		Expression other = (Expression) obj;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Expression [id=" + id + ", name=" + name + ", phrase=" + phrase + ", user=" + user + ", image=" + image
				+ "]";
	}

}