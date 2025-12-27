package com.microfinance.repository;


import java.util.List;

import java.util.Optional;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

import com.microfinance.model.FlexibleRenewal;
import com.microfinance.model.FlexiblepremiumrenewalPM;

@EnableJpaRepositories
public interface FlexibleRenewalRepo extends JpaRepository<FlexibleRenewal, Long>{


	List<FlexibleRenewal> findByIsApprovedFalse();


	List<FlexibleRenewal> findByPolicyCode(String policyCode);


	List<FlexibleRenewal> findByIsApprovedTrue();


}
