package com.happyshop.entity;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;

import org.hibernate.validator.constraints.Length;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "Users")
public class User {
	@Id
	@NotEmpty
	@Column(name = "Id")
	String id;
	@NotEmpty
	@Length(min=6)
	@Column(name = "Password")
	String password;
	@NotEmpty
	@Column(name = "Fullname")
	String fullname;
	@NotEmpty
	@Column(name = "Telephone", length = 50)
	String telephone;
	@NotEmpty
	@Email
	@Column(name = "Email")
	String email;
	@Column(name = "Photo")
	String photo;
	@Column(name = "Activated")
	Boolean activated;
	@Column(name = "Admin")
	Boolean admin;
	@Column(name = "isBanned")
	Boolean isBanned;

	@JsonIgnore
	@OneToMany(mappedBy = "user")
	List<Order> orders;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	
	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public Boolean getActivated() {
		return activated;
	}

	public void setActivated(Boolean activated) {
		this.activated = activated;
	}

	public Boolean getAdmin() {
		return admin;
	}

	public void setAdmin(Boolean admin) {
		this.admin = admin;
	}

	public List<Order> getOrders() {
		return orders;
	}

	public void setOrders(List<Order> orders) {
		this.orders = orders;
	}
	
	public Boolean getIsBanned() {
		return isBanned;
	}
	
	public void setIsBanned(Boolean isBanned) {
		this.isBanned = isBanned;
	}

}