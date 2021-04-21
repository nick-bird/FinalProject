package com.skilldistillery.projectemmy.entities;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

@Entity
@Table(name="soundboard_expression")
public class SoundboardExpression {
	
	@EmbeddedId
	private SoundboardExpressionId id;
	
	@Column(name="position_id")
	private int positionId;
	
	@ManyToOne
	@JoinColumn(name="soundboard_id")
	@MapsId(value="soundboardId")
	private Soundboard soundboard;
	
	@ManyToOne
	@JoinColumn(name="expression_id")
	@MapsId(value="expressionId")
	private Expression expression;

	public SoundboardExpression() {
		super();
	}

	public SoundboardExpression(SoundboardExpressionId id, int positionId, Soundboard soundboard,
			Expression expression) {
		super();
		this.id = id;
		this.positionId = positionId;
		this.soundboard = soundboard;
		this.expression = expression;
	}

	public SoundboardExpressionId getId() {
		return id;
	}

	public void setId(SoundboardExpressionId id) {
		this.id = id;
	}

	public int getPositionId() {
		return positionId;
	}

	public void setPositionId(int positionId) {
		this.positionId = positionId;
	}

	public Soundboard getSoundboard() {
		return soundboard;
	}

	public void setSoundboard(Soundboard soundboard) {
		this.soundboard = soundboard;
	}

	public Expression getExpression() {
		return expression;
	}

	public void setExpression(Expression expression) {
		this.expression = expression;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
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
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "SoundboardExpression [id=" + id + ", positionId=" + positionId + ", soundboard=" + soundboard
				+ ", expression=" + expression + "]";
	}

}
