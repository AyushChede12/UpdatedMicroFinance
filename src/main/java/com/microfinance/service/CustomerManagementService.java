package com.microfinance.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.nio.file.Path;
import java.nio.file.Files;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.microfinance.dto.ApiResponse;
import com.microfinance.dto.CustomerDto;
import com.microfinance.model.CreateSavingsAccount;
import com.microfinance.model.addCustomer;
import com.microfinance.model.addCustomerKYC;
import com.microfinance.repository.AddCustomerKycRepo;
import com.microfinance.repository.CustomerRepo;

@Service
public class CustomerManagementService {

	@Autowired
	CustomerRepo customerRepo;

	@Autowired
	AddCustomerKycRepo addCustomerKycRepo;

	@Value("${upload.directory}")

	private String uploadDirectory;

	public ApiResponse<addCustomer> saveOrUpdateCustomer(CustomerDto clientMasterDto, MultipartFile customerPhoto,
			MultipartFile customerSignature, MultipartFile customerDriving, MultipartFile customerVoter,
			MultipartFile nomineAadhar, MultipartFile nomineSignature) {
		addCustomer addcustomer = new addCustomer();
		boolean isNew = true;

// Update path
		if (clientMasterDto.getId() != null) {
			addcustomer = customerRepo.findById(clientMasterDto.getId()).orElse(new addCustomer());
			isNew = false;
		}

// Mapping fields
// You already did this correctly
		addcustomer.setMemberCode(clientMasterDto.getMemberCode());
		addcustomer.setAuthenticateFor(clientMasterDto.getAuthenticateFor());
		addcustomer.setSignupDate(clientMasterDto.getSignupDate());
		addcustomer.setCustomerName(clientMasterDto.getCustomerName());
		addcustomer.setGuardianName(clientMasterDto.getGuardianName());
		addcustomer.setRelationToApplicant(clientMasterDto.getRelationToApplicant());
		addcustomer.setCustomerGender(clientMasterDto.getCustomerGender());
		addcustomer.setDob(clientMasterDto.getDob());
		addcustomer.setCustomerAge(clientMasterDto.getCustomerAge());
		addcustomer.setRelationshipStatus(clientMasterDto.getRelationshipStatus());
		addcustomer.setCustomerAddress(clientMasterDto.getCustomerAddress());
		addcustomer.setDistrict(clientMasterDto.getDistrict());
		addcustomer.setState(clientMasterDto.getState());
		addcustomer.setBranchName(clientMasterDto.getBranchName());
		addcustomer.setPinCode(clientMasterDto.getPinCode());
		addcustomer.setAadharNo(clientMasterDto.getAadharNo());
		addcustomer.setPanNo(clientMasterDto.getPanNo());
		addcustomer.setVoterNo(clientMasterDto.getVoterNo());
		addcustomer.setContactNo(clientMasterDto.getContactNo());
		addcustomer.setMinor(clientMasterDto.getMinor());
		addcustomer.setEmailId(clientMasterDto.getEmailId());
		addcustomer.setProfession(clientMasterDto.getProfession());
		addcustomer.setAcademicBackground(clientMasterDto.getAcademicBackground());
		addcustomer.setReferralCode(clientMasterDto.getReferralCode());
		addcustomer.setReferralName(clientMasterDto.getReferralName());
		addcustomer.setDrivingLicenceNo(clientMasterDto.getDrivingLicenceNo());
		addcustomer.setShareAmount(clientMasterDto.getShareAmount());
		addcustomer.setNoOfShare(clientMasterDto.getNoOfShare());
		addcustomer.setLightBill(clientMasterDto.getLightBill());
		addcustomer.setTaxBill(clientMasterDto.getTaxBill());
		addcustomer.setFirstName(clientMasterDto.getFirstName());
		addcustomer.setMiddleName(clientMasterDto.getMiddleName());
		addcustomer.setLastName(clientMasterDto.getLastName());

// Nominee Details
		addcustomer.setNomineeName(clientMasterDto.getNomineeName());
		addcustomer.setNomineeRelationToApplicant(clientMasterDto.getNomineeRelationToApplicant());
		addcustomer.setNomineeAddress(clientMasterDto.getNomineeAddress());
		addcustomer.setNomineeKycNo(clientMasterDto.getNomineeKycNo());
		addcustomer.setNomineeMobileNo(clientMasterDto.getNomineeMobileNo());
		addcustomer.setNomineeAge(clientMasterDto.getNomineeAge());
		addcustomer.setNomineePanNo(clientMasterDto.getNomineePanNo());
		addcustomer.setNomineeKycType(clientMasterDto.getNomineeKycType());
		addcustomer.setNomineeDOB(clientMasterDto.getNomineeDOB());

// Payment details
		addcustomer.setMemberFees(clientMasterDto.getMemberFees());
		addcustomer.setBuildingFund(clientMasterDto.getBuildingFund());
		addcustomer.setAdminCharge(clientMasterDto.getAdminCharge());
		addcustomer.setDocumentCharge(clientMasterDto.getDocumentCharge());
		addcustomer.setEntryFee(clientMasterDto.getEntryFee());
		addcustomer.setOtherCharge(clientMasterDto.getOtherCharge());
		addcustomer.setChequeNo(clientMasterDto.getChequeNo());
		addcustomer.setChequeDate(clientMasterDto.getChequeDate());
		addcustomer.setDepositAcNo(clientMasterDto.getDepositAcNo());
		addcustomer.setReferenceNo(clientMasterDto.getReferenceNo());
		addcustomer.setRemarks(clientMasterDto.getRemarks());
		addcustomer.setPaymentBy(clientMasterDto.getPaymentBy());

// Additional
		addcustomer.setMemberBanking(clientMasterDto.getMemberBanking());
		addcustomer.setSmsSend(clientMasterDto.getSmsSend());
		addcustomer.setMemberStatus(clientMasterDto.getMemberStatus());
		addcustomer.setNetBanking(clientMasterDto.getNetBanking());

// Handle File Uploads
		try {
			if (customerPhoto != null && !customerPhoto.isEmpty()) {
				String photoFileName = saveFile(customerPhoto);
				addcustomer.setCustomerPhoto(photoFileName);
			}

			if (customerSignature != null && !customerSignature.isEmpty()) {
				String signFileName = saveFile(customerSignature);
				addcustomer.setCustomerSignature(signFileName);
			}

			if (customerVoter != null && !customerVoter.isEmpty()) {
				String voterFileName = saveFile(customerVoter);
				addcustomer.setCustomerVoter(voterFileName);
			}

			if (customerDriving != null && !customerDriving.isEmpty()) {
				String drivingFileName = saveFile(customerDriving);
				addcustomer.setCustomerDriving(drivingFileName);
			}

			if (nomineAadhar != null && !nomineAadhar.isEmpty()) {
				String nomineAadharFileName = saveFile(nomineAadhar);
				addcustomer.setNomineAadhar(nomineAadharFileName);
			}

			if (nomineSignature != null && !nomineSignature.isEmpty()) {
				String nomineSignatureFileName = saveFile(nomineSignature);
				addcustomer.setNomineSignature(nomineSignatureFileName);
				;
			}
		} catch (IOException e) {
			return ApiResponse.error(HttpStatus.INTERNAL_SERVER_ERROR, "File upload failed: " + e.getMessage());
		}

// Save entity
		addCustomer saved = customerRepo.save(addcustomer);

		if (isNew) {
			return ApiResponse.success(HttpStatus.CREATED,
					"Customer saved successfully. Member Code: " + saved.getMemberCode(), saved);
		} else {
			return ApiResponse.success(HttpStatus.OK,
					"Customer updated successfully. Member Code: " + saved.getMemberCode(), saved);
		}
	}

	private String saveFile(MultipartFile file) throws IOException {
		if (file != null && !file.isEmpty()) {
			ensureUploadDirectoryExists();
			String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
			File destination = new File(uploadDirectory + File.separator + fileName);
			file.transferTo(destination);
			return fileName;
		}
		return null;
	}

	private void ensureUploadDirectoryExists() {
		File uploadDir = new File(uploadDirectory);
		if (!uploadDir.exists()) {
			boolean created = uploadDir.mkdirs();
			if (created) {
				System.out.println("Upload directory created at: " + uploadDirectory);
			} else {
				System.err.println("Failed to create upload directory: " + uploadDirectory);
			}
		}
	}

	public List<addCustomer> getAllCustomer() {
		// TODO Auto-generated method stub
		return customerRepo.findAll();
	}

	public List<addCustomer> fetchBySelectedMember(String memberCode) {
		// TODO Auto-generated method stub
		return customerRepo.findBymemberCode(memberCode);
	}

	/*
	 * public ApiResponse<addCustomerKYC> saveOrUpdateCustomerKYC(addCustomerKYC
	 * kyc, MultipartFile customerPhoto, MultipartFile customerSignature,
	 * MultipartFile aadharFrontPhoto, MultipartFile aadharBackPhoto, MultipartFile
	 * panPhoto) {
	 * 
	 * boolean isNew = true;
	 * 
	 * // Step 1: Check if the base customer exists addCustomer baseCustomer =
	 * customerRepo.findById(kyc.getId()).orElse(null);
	 * 
	 * if (baseCustomer == null) { return ApiResponse.error(HttpStatus.NOT_FOUND,
	 * "Customer ID not found in master table."); }
	 * 
	 * // Step 2: Check if KYC already exists addCustomerKYC entity =
	 * addCustomerKycRepo.findById(kyc.getId()).orElse(new addCustomerKYC());
	 * 
	 * if (entity.getId() > 0) { isNew = false; }
	 * 
	 * // Step 3: Copy fields from form to entity
	 * entity.setSelectByCode(kyc.getSelectByCode());
	 * entity.setCustomerName(kyc.getCustomerName());
	 * entity.setCustomerCode(kyc.getCustomerCode());
	 * entity.setContactNo(kyc.getContactNo());
	 * entity.setSingupDate(kyc.getSingupDate());
	 * entity.setAadharNo(kyc.getAadharNo()); entity.setPan(kyc.getPan());
	 * entity.setVoterNo(kyc.getVoterNo());
	 * entity.setRationCardNo(kyc.getRationCardNo());
	 * entity.setDrivingLicenseNo(kyc.getDrivingLicenseNo());
	 * entity.setBankName(kyc.getBankName());
	 * entity.setBankBranch(kyc.getBankBranch());
	 * entity.setAcountNo(kyc.getAcountNo()); entity.setIfscCode(kyc.getIfscCode());
	 * 
	 * try { if (customerPhoto != null && !customerPhoto.isEmpty()) {
	 * entity.setCustomerPhoto(saveFile2(customerPhoto)); } if (customerSignature !=
	 * null && !customerSignature.isEmpty()) {
	 * entity.setCustomerSignature(saveFile2(customerSignature)); } if
	 * (aadharFrontPhoto != null && !aadharFrontPhoto.isEmpty()) {
	 * entity.setAadharFrontPhoto(saveFile2(aadharFrontPhoto)); } if
	 * (aadharBackPhoto != null && !aadharBackPhoto.isEmpty()) {
	 * entity.setAadharBackPhoto(saveFile2(aadharBackPhoto)); } if (panPhoto != null
	 * && !panPhoto.isEmpty()) { entity.setPanPhoto(saveFile2(panPhoto)); } } catch
	 * (IOException e) { return ApiResponse.error(HttpStatus.INTERNAL_SERVER_ERROR,
	 * "File upload failed: " + e.getMessage()); }
	 * 
	 * addCustomerKYC saved = addCustomerKycRepo.save(entity);
	 * 
	 * return ApiResponse.success(isNew ? HttpStatus.CREATED : HttpStatus.OK, (isNew
	 * ? "KYC saved" : "KYC updated") + " successfully for customer code: " +
	 * saved.getCustomerCode(), saved); }
	 * 
	 * private String saveFile2(MultipartFile file) throws IOException { if (file !=
	 * null && !file.isEmpty()) { ensureUploadDirectoryExists1(); String fileName =
	 * System.currentTimeMillis() + "_" + file.getOriginalFilename(); File
	 * destinationFile = new File(uploadDirectory + File.separator + fileName);
	 * file.transferTo(destinationFile); System.out.println("Saved at: " +
	 * destinationFile.getAbsolutePath()); return fileName; } return null; }
	 * 
	 * private void ensureUploadDirectoryExists1() { File dir = new
	 * File(uploadDirectory); if (!dir.exists()) { boolean created = dir.mkdirs();
	 * if (created) { System.out.println("Upload directory created: " +
	 * uploadDirectory); } else {
	 * System.err.println("Failed to create upload directory: " + uploadDirectory);
	 * } } }
	 */

	public List<addCustomer> getApprovedCustomers() {
		return customerRepo.findByIsApprovedTrue();
	}

}