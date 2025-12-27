package com.microfinance.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.microfinance.model.UserCreations;

@Repository
public interface UserCreationRepo extends JpaRepository<UserCreations, Long>{
	
	Optional<UserCreations> findByCustomerId(String customerId);
    boolean existsByCustomerId(String customerId);
    
}
