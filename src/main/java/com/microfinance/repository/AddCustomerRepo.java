package com.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.microfinance.model.addCustomer;

@Repository
public interface AddCustomerRepo extends JpaRepository<addCustomer, Long> {

	List<addCustomer> findByMemberCode(String memberCode);

	List<addCustomer> findByMemberCodeIgnoreCase(String memberCode);

	List<addCustomer> findByIsApprovedFalseAndMemberCode(String memberCode);

	List<addCustomer> findByIsApprovedFalse();

	List<addCustomer> findByBranchNameAndIsApprovedFalse(String branchName);

	

	List<addCustomer> findByIsApprovedTrue();
}
