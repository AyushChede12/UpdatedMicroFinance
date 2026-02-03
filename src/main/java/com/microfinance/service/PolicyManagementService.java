package com.microfinance.service;

import java.util.Collections;
import java.util.List;

import java.util.Optional;
import java.util.stream.Collectors;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import com.microfinance.dto.ApiResponse;
import com.microfinance.dto.PolicyManagementDto;
import com.microfinance.model.AddnewinvestmentPM;
import com.microfinance.model.CreateSavingsAccount;
import com.microfinance.model.DailyDepositPM;
import com.microfinance.model.DailyPremiumRenewalPM;
import com.microfinance.model.FixedDepositPM;
import com.microfinance.model.FlexibleRenewal;
import com.microfinance.model.FullMaturity;
import com.microfinance.model.MISDepositPM;
import com.microfinance.model.PolicyRenewal;
import com.microfinance.model.RecurringDepositPM;
import com.microfinance.repository.AddInvestmentRepo;
import com.microfinance.repository.DailyDepositPMRepo;
import com.microfinance.repository.DailyPremiumRenewalRepo;
import com.microfinance.repository.FixedDepositPMRepo;
import com.microfinance.repository.FlexibleRenewalRepo;
import com.microfinance.repository.FullMaturityRepo;
import com.microfinance.repository.MisDepositePMRepo;
import com.microfinance.repository.PolicyRenewalRepo;
import com.microfinance.repository.RecurringDepositRepo;

@Service
public class PolicyManagementService {
	@Autowired
	DailyDepositPMRepo dailyDepositPMRepo;

	@Autowired
	RecurringDepositRepo recurringDepositRepo;

	@Autowired
	FixedDepositPMRepo fixedDepositPMRepo;

	@Autowired
	MisDepositePMRepo misDepositePMRepo;

	@Autowired
	AddInvestmentRepo addinvestmentrepo;

	@Autowired
	PolicyRenewalRepo policyRenewalRepo;

	@Autowired
	DailyPremiumRenewalRepo dailyPremiumRenewalRepo;

	@Autowired
	FlexibleRenewalRepo flexibleRenewalRepo;
	
	@Autowired
	FullMaturityRepo fullMaturityRepo;

	public boolean saveRecuringDailyDeposite(RecurringDepositPM deposit) {
		try {
			recurringDepositRepo.save(deposit);
			return true;
		} catch (Exception e) {
			e.printStackTrace(); // Log actual error
			return false;
		}
	}

	public List<RecurringDepositPM> getAllData1() {
		// TODO Auto-generated method stub
		return recurringDepositRepo.findAll();
	}

// fixed deposite of the service
	public boolean saveFixedDeposite(FixedDepositPM fixedDepositPM) {
		// TODO Auto-generated method stub
		try {
			fixedDepositPMRepo.save(fixedDepositPM);
			return true;
		} catch (Exception e) {
			e.printStackTrace(); // Log actual error
			return false;
		}
	}

// feacth all data of the fixed deposite
	public List<FixedDepositPM> getAllFixeddata() {
		// TODO Auto-generated method stub
		return fixedDepositPMRepo.findAll();
	}

// daily Deposite save service
	public boolean savedailydeposite(DailyDepositPM dailyDepositPM) {
		// TODO Auto-generated method stub
		try {
			dailyDepositPMRepo.save(dailyDepositPM);
			return true;
		} catch (Exception e) {
			e.printStackTrace(); // Log actual error
			return false;
		}
	}

//feacth all data of the daily deposite
	public List<DailyDepositPM> getAlldailydepositedata() {
		// TODO Auto-generated method stub
		return dailyDepositPMRepo.findAll();
	}

//MIS Deposite save service
	public boolean savemistdeposite(MISDepositPM misDepositPM) {
		try {
			misDepositePMRepo.save(misDepositPM);
			return true;
		} catch (Exception e) {
			e.printStackTrace(); // Log actual error
			return false;
		}
	}

	public List<MISDepositPM> getAllMISDepositData() {
		// TODO Auto-generated method stub
		return misDepositePMRepo.findAll();
	}

	public DailyDepositPM getDailyDepositById(Long id) {
		// TODO Auto-generated method stub
		return dailyDepositPMRepo.findById(id).orElse(null);
	}

	public DailyDepositPM updateDailyDeposit(Long id, DailyDepositPM updatedData) {
		// TODO Auto-generated method stub

		return dailyDepositPMRepo.findById(id).map(existing -> {
			existing.setPlanCodeDD(updatedData.getPlanCodeDD());
			existing.setMinimumDeposit(updatedData.getMinimumDeposit());
			existing.setRateOfInterest(updatedData.getRateOfInterest());
			existing.setInstallmentType(updatedData.getInstallmentType());
			existing.setPlanNameDD(updatedData.getPlanNameDD());
			existing.setCommissionOnNew(updatedData.getCommissionOnNew());
			existing.setRenewalCommission(updatedData.getRenewalCommission());
			existing.setDdterm(updatedData.getDdterm());
			existing.setInterestInterval(updatedData.getInterestInterval());
			existing.setTotalPaid(updatedData.getTotalPaid());
			existing.setMaturityAmount(updatedData.getMaturityAmount());
			existing.setFlexiblePlan(updatedData.getFlexiblePlan());
			existing.setGraceDays(updatedData.getGraceDays());
			existing.setPenaltyRate(updatedData.getPenaltyRate());
			existing.setStatusOfPlan(updatedData.getStatusOfPlan());

			return dailyDepositPMRepo.save(existing); // Fixed here
		}).orElse(null);
	}

	public boolean deleteDailyDeposit(Long id) {
		// TODO Auto-generated method stub
		if (dailyDepositPMRepo.existsById(id)) {
			dailyDepositPMRepo.deleteById(id);
			return true;
		} else {
			return false;
		}
	}

// edit by id reccuring deposite
	public RecurringDepositPM getRecurringDepositById(Long id) {
		// TODO Auto-generated method stub
		return recurringDepositRepo.findById(id).orElse(null);
	}

//update the reccuring deposite service
	public RecurringDepositPM updateRecurringDeposit(Long id, RecurringDepositPM updatedData) {
		Optional<RecurringDepositPM> existingOptional = recurringDepositRepo.findById(id);

		if (existingOptional.isPresent()) {
			RecurringDepositPM existing = existingOptional.get();

			// 🔁 Update all fields manually
			existing.setPlanCodeRD(updatedData.getPlanCodeRD());
			existing.setPlanNameRD(updatedData.getPlanNameRD());
			existing.setMinimumAmountRD(updatedData.getMinimumAmountRD());
			existing.setRateOfInterestRD(updatedData.getRateOfInterestRD());
			existing.setInstallmentTypeRD(updatedData.getInstallmentTypeRD());
			existing.setRdterm(updatedData.getRdterm());
			existing.setCommissionOnNewRD(updatedData.getCommissionOnNewRD());
			existing.setRenewalCommissionRD(updatedData.getRenewalCommissionRD());
			existing.setComponentIntervalRD(updatedData.getComponentIntervalRD());
			existing.setTotalPaidRD(updatedData.getTotalPaidRD());
			existing.setMaturityAmountRD(updatedData.getMaturityAmountRD());
			existing.setFlexiblePlanRD(updatedData.getFlexiblePlanRD());
			existing.setGraceDaysRD(updatedData.getGraceDaysRD());
			existing.setPenaltyfineRD(updatedData.getPenaltyfineRD());
			existing.setStatusOfPlanRD(updatedData.getStatusOfPlanRD());

			// Save updated object
			return recurringDepositRepo.save(existing);
		} else {
			return null; // ❌ ID not found
		}
	}

//delete the recurring deposit service

	public boolean deleteRecurringDeposit(Long id) {
		if (recurringDepositRepo.existsById(id)) {
			recurringDepositRepo.deleteById(id);
			return true;
		} else {
			return false;
		}
	}

//Fetch the data fixed deposit service

	public FixedDepositPM getFixedDepositById(Long id) {
		// TODO Auto-generated method stub
		return fixedDepositPMRepo.findById(id).orElse(null);
	}

	public FixedDepositPM updateFixedDeposit(Long id, FixedDepositPM updatedData) {
		Optional<FixedDepositPM> existingOptional = fixedDepositPMRepo.findById(id);

		if (existingOptional.isPresent()) {
			FixedDepositPM existing = existingOptional.get();

			// Update all fields
			existing.setPlanCodeFD(updatedData.getPlanCodeFD());
			existing.setPlanNameFD(updatedData.getPlanNameFD());
			existing.setMinimumAmountFD(updatedData.getMinimumAmountFD());
			existing.setRateOfInterestFD(updatedData.getRateOfInterestFD());
			existing.setFdterm(updatedData.getFdterm());
			existing.setInstallmentTypeFD(updatedData.getInstallmentTypeFD());
			existing.setCommissionOnNewFD(updatedData.getCommissionOnNewFD());
			existing.setComponentIntervalFD(updatedData.getComponentIntervalFD());
			existing.setTotalPaidFD(updatedData.getTotalPaidFD());
			existing.setMaturityAmountFD(updatedData.getMaturityAmountFD());
			existing.setFlexiblePlanFD(updatedData.getFlexiblePlanFD());
			existing.setRenewalCommissionFD(updatedData.getRenewalCommissionFD());
			existing.setGraceDaysFD(updatedData.getGraceDaysFD());
			existing.setPenltyfineFD(updatedData.getPenltyfineFD());
			existing.setStatusOfPlanFD(updatedData.getStatusOfPlanFD());

			return fixedDepositPMRepo.save(existing); // save updated data
		}

		return null; // not found
	}

	public boolean deleteFixedDeposit(Long id) {
		if (fixedDepositPMRepo.existsById(id)) {
			fixedDepositPMRepo.deleteById(id);
			return true;
		} else {
			return false;
		}
	}

	public MISDepositPM getMISDepositById(Long id) {
		// TODO Auto-generated method stub
		return misDepositePMRepo.findById(id).orElse(null);
	}

	public MISDepositPM updateMISDeposit(Long id, MISDepositPM updatedData) {
		// TODO Auto-generated method stub
		Optional<MISDepositPM> existingOptional = misDepositePMRepo.findById(id);

		if (existingOptional.isPresent()) {
			MISDepositPM existing = existingOptional.get();

			// Set fields from updatedData to existing
			existing.setPlanCodeMD(updatedData.getPlanCodeMD());
			existing.setPlanNameMD(updatedData.getPlanNameMD());
			existing.setRateOfInterestMD(updatedData.getRateOfInterestMD());
			existing.setInstallmentTypeMD(updatedData.getInstallmentTypeMD());
			existing.setMinimumAmountMD(updatedData.getMinimumAmountMD());
			existing.setMaturityROIMD(updatedData.getMaturityROIMD());
			existing.setMisTerm(updatedData.getMisTerm());
			existing.setMISIntROIMD(updatedData.getMISIntROIMD());
			existing.setMISIntervalMD(updatedData.getMISIntervalMD());
			existing.setMISInterestMD(updatedData.getMISInterestMD());
			existing.setMaturityAmountMD(updatedData.getMaturityAmountMD());
			existing.setFlexiblePlanMD(updatedData.getFlexiblePlanMD());
			existing.setCommissionOnNewMD(updatedData.getCommissionOnNewMD());
			existing.setRenewalCommissionMD(updatedData.getRenewalCommissionMD());
			existing.setStatusOfPlanMDRD2(updatedData.getStatusOfPlanMDRD2());

			return misDepositePMRepo.save(existing);
		}
		return null;

	}

	public boolean deleteMISDeposit(Long id) {
		if (misDepositePMRepo.existsById(id)) {
			misDepositePMRepo.deleteById(id);
			return true;
		} else {
			return false;
		}
	}

//Ashwini
	/*
	 * public List<AddnewinvestmentPM> getAddInvestmentDetails() { // TODO
	 * Auto-generated method stub return addinvestmentrepo.findAll(); }
	 */

	public List<String> getSchemeNameBySchemeType(String drd) {
		List<DailyDepositPM> allDrdPlans = dailyDepositPMRepo.findBydrd(drd);
		return allDrdPlans.stream().map(DailyDepositPM::getPlanNameDD).distinct().collect(Collectors.toList());
	}

	public List<String> getRRDBySchemeType(String rd) {
		List<RecurringDepositPM> allRrdPlans = recurringDepositRepo.findByrd(rd);
		return allRrdPlans.stream().map(RecurringDepositPM::getPlanNameRD).distinct().collect(Collectors.toList());
	}

	public List<String> getFRDBySchemeType(String fd) {
		List<FixedDepositPM> allFrdPlans = fixedDepositPMRepo.findByfd(fd);
		return allFrdPlans.stream().map(FixedDepositPM::getPlanNameFD).distinct().collect(Collectors.toList());

	}

	public List<String> getMISRDBySchemeType(String mis) {
		List<MISDepositPM> allMisrdPlans = misDepositePMRepo.findBymis(mis);
		return allMisrdPlans.stream().map(MISDepositPM::getPlanNameMD).distinct().collect(Collectors.toList());
	}

	public DailyDepositPM getDDTermAndInterestRate(String planNameDD) {
		return dailyDepositPMRepo.findByplanNameDD(planNameDD);
	}

	public List<AddnewinvestmentPM> getAddInvestmentDetails() {
		// TODO Auto-generated method stub
		return addinvestmentrepo.findAll();
	}

	public RecurringDepositPM getRDTermAndInterestRate(String planNameRD) {
		return recurringDepositRepo.findByplanNameRD(planNameRD);
	}

	public FixedDepositPM getFDTermAndInterestRate(String planNameFD) {
		return fixedDepositPMRepo.findByplanNameFD(planNameFD);
	}

	public MISDepositPM getMISTermAndInterestRate(String planNameMD) {
		return misDepositePMRepo.findByplanNameMD(planNameMD);
	}

	public List<AddnewinvestmentPM> findByBranch(String branchName) {
		// TODO Auto-generated method stub
		List<AddnewinvestmentPM> list = addinvestmentrepo.findByBranchName(branchName);
		return list;
	}

	public AddnewinvestmentPM getDetailsById(Long id) {
		// TODO Auto-generated method stub
		return addinvestmentrepo.findById(id).orElse(null);
	}

	public AddnewinvestmentPM saveInvestment(AddnewinvestmentPM investment) {
		return addinvestmentrepo.save(investment);
	}

	public List<DailyDepositPM> getAllDDTerm() {
		// TODO Auto-generated method stub
		return dailyDepositPMRepo.findAll();
	}

	public List<AddnewinvestmentPM> getAllInvestments() {
		return addinvestmentrepo.findAll();
	}
	
	public List<AddnewinvestmentPM> getAllPolicyManagementData() {
		// TODO Auto-generated method stub
		return addinvestmentrepo.findAll();
	}

	public List<AddnewinvestmentPM> x() {
		// TODO Auto-generated method stub
		return addinvestmentrepo.findAll();
	}

	public Optional<AddnewinvestmentPM> findByPolicyCode(String policyCode) {
		if (policyCode == null)
			return Optional.empty();

		// Clean input: trim and convert to uppercase
		String normalizedCode = policyCode.trim().toUpperCase();

		// Fetch all and match manually
		return addinvestmentrepo.findAll().stream()
				.filter(p -> p.getPolicyCode() != null && p.getPolicyCode().trim().equalsIgnoreCase(normalizedCode))
				.findFirst();
	}

	public List<AddnewinvestmentPM> getApprovedInvestments() {
		// TODO Auto-generated method stub
		return addinvestmentrepo.findByIsApprovedTrue();
	}

	public List<AddnewinvestmentPM> getApprovedRDPolicies() {
		return addinvestmentrepo.findApprovedRDPolicies();
	}

	public List<AddnewinvestmentPM> getApprovedFDPolicies() {
		return addinvestmentrepo.findApprovedFDPolicies();
	}

	public List<AddnewinvestmentPM> getApprovedDDPolicies() {
		// TODO Auto-generated method stub
		return addinvestmentrepo.findApprovedDDPolicies();
	}

	public List<AddnewinvestmentPM> getAllRdRenewalData() {
		// TODO Auto-generated method stub
		return addinvestmentrepo.findAll();
	}

	public List<AddnewinvestmentPM> getAllDdRenewalData() {
		// TODO Auto-generated method stub
		return addinvestmentrepo.findAll();
	}

	public List<AddnewinvestmentPM> getAllFdRenewalData() {
		// TODO Auto-generated method stub
		return addinvestmentrepo.findAll();
	}

	public List<AddnewinvestmentPM> getAllApprovedPolicies() {
		return addinvestmentrepo.findByIsApprovedTrue();
	}

	public AddnewinvestmentPM updateInstalmentDetails(String policyCode, String DepositAmount) {
		Optional<AddnewinvestmentPM> optionalInvestment = addinvestmentrepo.findByPolicyCode(policyCode);

		if (optionalInvestment.isPresent()) {
			AddnewinvestmentPM investment = optionalInvestment.get();

			// Set the new deposit amount
			investment.setDepositAmount(DepositAmount);

			// Increment lastInstPaid
			try {
				int last = Integer
						.parseInt(investment.getLastInstPaid() == null || investment.getLastInstPaid().isEmpty() ? "0"
								: investment.getLastInstPaid());
				investment.setLastInstPaid(String.valueOf(last + 1));
			} catch (NumberFormatException e) {
				investment.setLastInstPaid("1");
			}

			// Save and return updated investment
			return addinvestmentrepo.save(investment);
		}

		return null; // or throw custom exception if you prefer
	}

	public List<FlexibleRenewal> findBypolicyCode(String policyCode) {
		return flexibleRenewalRepo.findByPolicyCode(policyCode);
	}

	public List<DailyPremiumRenewalPM> findDailyData(String policyCode) {
		return dailyPremiumRenewalRepo.findByPolicyCode(policyCode);
	}

	public List<PolicyRenewal> findRenewalData(String policyCode) {
		return policyRenewalRepo.findByPolicyCode(policyCode);
	}

	public ApiResponse<AddnewinvestmentPM> saveandupdateAddInvestmentDetails(PolicyManagementDto policyManagementDto,
			String image1, String image2) {
		// TODO Auto-generated method stub
		AddnewinvestmentPM addnewinvestmentPM = new AddnewinvestmentPM();
		boolean isNew = true;

		// Check if the ClientMaster is being updated
		if (policyManagementDto.getId() != null && policyManagementDto.getId() > 0) {
			addnewinvestmentPM = addinvestmentrepo.findById(policyManagementDto.getId())
					.orElse(new AddnewinvestmentPM());
			isNew = false;
		}

		// Map fields from DTO to entity
		addnewinvestmentPM.setPolicyCode(policyManagementDto.getPolicyCode());
		addnewinvestmentPM.setPolicyStartDate(policyManagementDto.getPolicyStartDate());
		addnewinvestmentPM.setMemberSelection(policyManagementDto.getMemberSelection());
		addnewinvestmentPM.setCustomerName(policyManagementDto.getCustomerName());
		addnewinvestmentPM.setDateofBirth(policyManagementDto.getDateofBirth());
		addnewinvestmentPM.setRelationDetails(policyManagementDto.getRelationDetails());
		addnewinvestmentPM.setContactNo(policyManagementDto.getContactNo());
		addnewinvestmentPM.setSuggestedNominee(policyManagementDto.getSuggestedNominee());
		addnewinvestmentPM.setAgeOfNominee(policyManagementDto.getAgeOfNominee());
		addnewinvestmentPM.setRelation(policyManagementDto.getRelation());
		addnewinvestmentPM.setAddress(policyManagementDto.getAddress());
		addnewinvestmentPM.setDistrict(policyManagementDto.getDistrict());
		addnewinvestmentPM.setState(policyManagementDto.getState());
		addnewinvestmentPM.setPinCode(policyManagementDto.getPinCode());
		addnewinvestmentPM.setTds(policyManagementDto.getTds());
		addnewinvestmentPM.setBranchName(policyManagementDto.getBranchName());
		addnewinvestmentPM.setModeOfOperation(policyManagementDto.getModeOfOperation());
		addnewinvestmentPM.setJointMemCode(policyManagementDto.getJointMemCode());
		addnewinvestmentPM.setJointName(policyManagementDto.getJointName());
		addnewinvestmentPM.setMaturityDate(policyManagementDto.getMaturityDate());
		addnewinvestmentPM.setSchemeType(policyManagementDto.getSchemeType());
		addnewinvestmentPM.setSchemeTerm(policyManagementDto.getSchemeTerm());
		addnewinvestmentPM.setSchemeMode(policyManagementDto.getSchemeMode());
		addnewinvestmentPM.setRoi(policyManagementDto.getRoi());
		addnewinvestmentPM.setPolicyAmount(policyManagementDto.getPolicyAmount());
		addnewinvestmentPM.setDepositAmount(policyManagementDto.getDepositAmount());
		addnewinvestmentPM.setIntroMCode(policyManagementDto.getIntroMCode());
		addnewinvestmentPM.setMaturityAmount(policyManagementDto.getMaturityAmount());
		addnewinvestmentPM.setMISInterest(policyManagementDto.getMISInterest());
		addnewinvestmentPM.setPaidAmount(policyManagementDto.getPaidAmount());
		addnewinvestmentPM.setLastInstPaid(policyManagementDto.getLastInstPaid());
		

		addnewinvestmentPM.setPaymentBy(policyManagementDto.getPaymentBy());
		addnewinvestmentPM.setSchemeCode(policyManagementDto.getSchemeCode());
		addnewinvestmentPM.setRemark(policyManagementDto.getRemark());
		addnewinvestmentPM.setAgent(policyManagementDto.getAgent());
		addnewinvestmentPM.setSmsSend(policyManagementDto.getSmsSend());
		// Set photo path (already fetched)
		if (image1 != null && !image1.isEmpty()) {
			addnewinvestmentPM.setImage1(image1);
		}

		// Handle signature upload
		if (image2 != null && !image2.isEmpty()) {
			addnewinvestmentPM.setImage2(image2);
		}

		// Handle photo upload
		/*
		 * if (photo != null && !photo.isEmpty()) { try { String fileName1 =
		 * saveFile(photo); // Save the signature
		 * createSavingsAccount.setPhoto(fileName1); } catch (IOException e) { return
		 * ApiResponse.error(HttpStatus.INTERNAL_SERVER_ERROR, "File upload failed"); }
		 * }
		 */

		// Handle signature upload
		/*
		 * if (signature != null && !signature.isEmpty()) { try { String fileName1 =
		 * saveFile1(signature); // Save the signature
		 * createSavingsAccount.setSignature(fileName1); } catch (IOException e) {
		 * return ApiResponse.error(HttpStatus.INTERNAL_SERVER_ERROR,
		 * "File upload failed"); } }
		 */

		// Save entity to the database
		AddnewinvestmentPM saveaddinvestmentPM = addinvestmentrepo.save(addnewinvestmentPM);

		if (isNew) {
			return ApiResponse.success(HttpStatus.CREATED,
					"Saved successfully. Director Name: " + saveaddinvestmentPM.getCustomerName(), saveaddinvestmentPM);
		} else {
			return ApiResponse.success(HttpStatus.OK,
					"Updated successfully. Director Name: " + saveaddinvestmentPM.getCustomerName(),
					saveaddinvestmentPM);
		}
	}

	public boolean existByMemberSelection(String customerCode) {
		// TODO Auto-generated method stub
		return addinvestmentrepo.existsByMemberSelection(customerCode);
	}

	public List<FullMaturity> fetchFullMaturityByPolicyCode(String policyCode) {
	    if (policyCode == null || policyCode.trim().isEmpty()) {
	        return Collections.emptyList(); // returns an immutable empty list
	    }
	    return fullMaturityRepo.findByPolicyCodeIgnoreCase(policyCode.trim());
	}


	public boolean deletePolicyDataById(Long id) {
		// TODO Auto-generated method stub
		if (addinvestmentrepo.existsById(id)) {
			addinvestmentrepo.deleteById(id);
			return true;
		} else {
			return false;
		}
	}

	public List<FullMaturity> getAllApprovedRDPolicies() {
		// TODO Auto-generated method stub
		return fullMaturityRepo.findByApproveStatusTrue();
	}

}
