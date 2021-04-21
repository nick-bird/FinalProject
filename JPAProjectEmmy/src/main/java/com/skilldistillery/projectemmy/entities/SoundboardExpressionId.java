package com.skilldistillery.projectemmy.entities;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class SoundboardExpressionId implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	@Column(name="soundboard_id")
	private int soundboardId;
	
	@Column(name="expression_id")
	private int expressionId;

	public SoundboardExpressionId() {
		super();
	}

	public SoundboardExpressionId(int soundboardId, int expressionId) {
		super();
		this.soundboardId = soundboardId;
		this.expressionId = expressionId;
	}

	public int getSoundboardId() {
		return soundboardId;
	}

	public void setSoundboardId(int soundboardId) {
		this.soundboardId = soundboardId;
	}

	public int getExpressionId() {
		return expressionId;
	}

	public void setExpressionId(int expressionId) {
		this.expressionId = expressionId;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + expressionId;
		result = prime * result + soundboardId;
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
		SoundboardExpressionId other = (SoundboardExpressionId) obj;
		if (expressionId != other.expressionId)
			return false;
		if (soundboardId != other.soundboardId)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "SoundboardExpressionId [soundboardId=" + soundboardId + ", expressionId=" + expressionId + "]";
	}

}
