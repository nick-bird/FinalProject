package com.skilldistillery.projectemmy.entities;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.Table;

@Embeddable
@Table(name="soundboard_expression")
public class SoundboardExpression implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	@Column(name="position_id")
	private int positionId;

	public SoundboardExpression() {
		super();
	}

	public SoundboardExpression(int positionId) {
		super();
		this.positionId = positionId;
	}

	public int getPositionId() {
		return positionId;
	}

	public void setPositionId(int positionId) {
		this.positionId = positionId;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + positionId;
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
		SoundboardExpression other = (SoundboardExpression) obj;
		if (positionId != other.positionId)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "SoundboardExpression [positionId=" + positionId + "]";
	}
	
}
