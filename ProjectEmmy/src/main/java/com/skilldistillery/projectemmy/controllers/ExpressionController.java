package com.skilldistillery.projectemmy.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.projectemmy.entities.Expression;
import com.skilldistillery.projectemmy.services.ExpressionService;

@CrossOrigin({"*", "http://localhost:4290"})
@RequestMapping("api")
@RestController
public class ExpressionController {

	@Autowired
	private ExpressionService expSvc;
	
	
	@GetMapping("expressions")
	public List<Expression> index(HttpServletRequest req, HttpServletResponse res, Principal principal) { 
		return expSvc.index(principal.getName());
	}

	@GetMapping("expressions/{eid}")
	public Expression show(HttpServletRequest req, HttpServletResponse res, @PathVariable int eid, Principal principal) {
		Expression exp = expSvc.show(principal.getName(), eid);
		
		if(exp == null) {
			res.setStatus(404);
		}
		return exp;
	}

	@PostMapping("expressions")
	public Expression create(HttpServletRequest req, HttpServletResponse res, @RequestBody Expression exp, Principal principal) {
		try {
			exp = expSvc.create(principal.getName(),exp);
			res.setStatus(201);
			StringBuffer url = req.getRequestURL();
			url.append("/").append(exp.getId());
			res.setHeader("Location", url.toString());
		} catch (Exception e) {
			System.err.println(e);
			res.setStatus(400);
			exp = null;
		}
		return exp;
	}

	
	@PutMapping("expressions/{eid}")
	public Expression update(HttpServletRequest req, HttpServletResponse res, @PathVariable int eid,@RequestBody Expression exp, Principal principal) {
		
		try {
			exp = expSvc.update(principal.getName(),eid,exp);
			if (exp == null) {
				res.setStatus(404);
			}
		} catch (Exception e) {
			System.err.println(e);
			res.setStatus(400);
			exp = null;
		}
		return exp;
	}


	@DeleteMapping("expressions/{eid}")
	public void destroy(HttpServletRequest req, HttpServletResponse res, @PathVariable int eid, Principal principal) {
		
	if(expSvc.show(principal.getName(), eid) == null) {
		res.setStatus(404);
	}

	try {
		if(expSvc.destroy(principal.getName(), eid)) {
			res.setStatus(204);
		} else {
			res.setStatus(404);
		}
	} catch (Exception e) {
		System.err.println(e);
		res.setStatus(400);
	}
	}

	
	
}
