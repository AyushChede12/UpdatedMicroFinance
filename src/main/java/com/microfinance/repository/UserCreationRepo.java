package com.microfinance.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.microfinance.model.UserCreation;

@Repository
public interface UserCreationRepo extends JpaRepository<UserCreation, Long>{
	
	Optional<UserCreation> findByUserId(String userId);
    boolean existsByUserId(String userId);
    
}
