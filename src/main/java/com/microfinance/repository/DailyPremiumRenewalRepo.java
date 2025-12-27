package com.microfinance.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.microfinance.model.DailyPremiumRenewalPM;


@Repository

public interface DailyPremiumRenewalRepo extends JpaRepository<DailyPremiumRenewalPM, Long> {

	List<DailyPremiumRenewalPM> findByIsApprovedFalse();

	List<DailyPremiumRenewalPM> findByPolicyCode(String policyCode);
	List<DailyPremiumRenewalPM> findByIsApprovedTrue();

	//Optional<DailyPremiumRenewalPM> findByPolicyCode(String policyCode);

}
