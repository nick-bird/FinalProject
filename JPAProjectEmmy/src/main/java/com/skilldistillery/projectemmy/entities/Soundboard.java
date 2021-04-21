package com.skilldistillery.projectemmy.entities;

import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import org.hibernate.annotations.CreationTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class Soundboard {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	@Column(name = "is_public")
	private Boolean isPublic;
	
	private String description;
	
	@Column(name="create_date")
	@CreationTimestamp
	private LocalDateTime createDate;
	
	@Column(name = "is_default")
	private Boolean isDefault;
	
	@JsonIgnore
	@OneToMany(mappedBy="soundboard")
	private List<SoundboardExpression> soundboardExpressions;
	
	@JsonIgnore
	@ManyToMany
	@JoinTable(name="soundboard_category",
	joinColumns=@JoinColumn(name="soundboard_id"),
	inverseJoinColumns=@JoinColumn(name="category_id"))
	private List<Category> categories;
	
	@ManyToOne()
	@JoinColumn(name="user_id")
	private User user;
	
	public Soundboard() {}
	
	public Soundboard(int id, String name, Boolean isPublic, String description, LocalDateTime createDate,
			Boolean isDefault, List<SoundboardExpression> soundboardExpressions, List<Category> categories, User user) {
		super();
		this.id = id;
		this.name = name;
		this.isPublic = isPublic;
		this.description = description;
		this.createDate = createDate;
		this.isDefault = isDefault;
		this.soundboardExpressions = soundboardExpressions;
		this.categories = categories;
		this.user = user;
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

	public Boolean getIsPublic() {
		return isPublic;
	}

	public void setIsPublic(Boolean isPublic) {
		this.isPublic = isPublic;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public LocalDateTime getCreateDate() {
		return createDate;
	}

	public void setCreateDate(LocalDateTime createDate) {
		this.createDate = createDate;
	}

	public Boolean getIsDefault() {
		return isDefault;
	}

	public void setIsDefault(Boolean isDefault) {
		this.isDefault = isDefault;
	}

	public List<SoundboardExpression> getSoundboardExpressions() {
		return soundboardExpressions;
	}

	public void setSoundboardExpressions(List<SoundboardExpression> soundboardExpressions) {
		this.soundboardExpressions = soundboardExpressions;
	}

	public List<Category> getCategories() {
		return categories;
	}

	public void setCategories(List<Category> categories) {
		this.categories = categories;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
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
		Soundboard other = (Soundboard) obj;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Soundboard [id=" + id + ", name=" + name + ", isPublic=" + isPublic + ", description=" + description
				+ ", createDate=" + createDate + ", isDefault=" + isDefault + ", soundboardExpressions="
				+ soundboardExpressions + ", categories=" + categories + ", user=" + user + "]";
	}

}