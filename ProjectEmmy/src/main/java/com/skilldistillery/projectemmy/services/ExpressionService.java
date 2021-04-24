package com.skilldistillery.projectemmy.services;

import java.util.List;

import com.skilldistillery.projectemmy.entities.Expression;

public interface ExpressionService {

	public List<Expression> index(String username);

    public Expression show(String username, int eid);

    public Expression create(String username, Expression exp);

    public Expression update(String username, int eid, Expression exp);

    public boolean destroy(String username, int eid);
    
    public List<Expression> indexPublic();
    
    public List<Expression> getDefaultExpressions(String username);
	
}
