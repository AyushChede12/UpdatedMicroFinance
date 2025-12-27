package com.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.microfinance.model.UserCreations;
import com.microfinance.model.UserMenuAccess;

@Repository
public interface UserMenuAccessRepo extends JpaRepository<UserMenuAccess, Long>{
	
	List<UserMenuAccess> findByUserCreations_CustomerId(String customerId);
    void deleteByUserCreations_CustomerId(String customerId);

}
