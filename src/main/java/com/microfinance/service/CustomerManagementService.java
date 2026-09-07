package com.microfinance.service;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.concurrent.CompletableFuture;
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
import com.microfinance.model.BranchModule;
import com.microfinance.repository.AddCustomerKycRepo;
import com.microfinance.repository.CustomerRepo;
import com.microfinance.repository.CreateSavingAccountRepo;
import com.microfinance.repository.BranchModuleRepo;
import org.springframework.util.StringUtils;
import java.util.Optional;
import java.util.ArrayList;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.core.type.TypeReference;

@Service
public class CustomerManagementService {

	@Autowired
	CustomerRepo customerRepo;

	@Autowired
	AddCustomerKycRepo addCustomerKycRepo;

	@Autowired
	CreateSavingAccountRepo createSavingAccountRepo;

	@Autowired
	BranchModuleRepo branchModuleRepo;

	@Value("${upload.directory}")

	private String uploadDirectory;

	@Autowired
	private JavaMailSender mailSender;


	public ApiResponse<?> saveOrUpdateCustomer(CustomerDto clientMasterDto, MultipartFile customerAadharImage,
			MultipartFile customerPanImage, MultipartFile customerPhoto, MultipartFile customerVoter,
			MultipartFile nomineAadhar, MultipartFile nomineSignature, MultipartFile customerSignature) {

		// ✅ Validation: customerName and contactNo are required fields
		if (clientMasterDto.getId() == null) { // Only validate on new customer creation
			if (clientMasterDto.getCustomerName() == null || clientMasterDto.getCustomerName().trim().isEmpty()) {
				return ApiResponse.error(HttpStatus.BAD_REQUEST, "Customer Name is required and cannot be empty.");
			}
			if (clientMasterDto.getContactNo() == null || clientMasterDto.getContactNo().trim().isEmpty()) {
				return ApiResponse.error(HttpStatus.BAD_REQUEST, "Contact Number is required and cannot be empty.");
			}
		}

		addCustomer addcustomer = new addCustomer();
		boolean isNew = true;

		// Update path
		if (clientMasterDto.getId() != null) {
			addcustomer = customerRepo.findById(clientMasterDto.getId()).orElse(new addCustomer());
			isNew = false;
		}

		// Mapping fields
		// Map text fields to uppercase for uniform database storage
		addcustomer.setMemberCode(toUpper(clientMasterDto.getMemberCode()));
		addcustomer.setMemberType(toUpper(clientMasterDto.getMemberType()));
		addcustomer.setSignupDate(clientMasterDto.getSignupDate());
		addcustomer.setMajor(toUpper(clientMasterDto.getMajor()));
		addcustomer.setCustomerName(toUpper(clientMasterDto.getCustomerName()));
		addcustomer.setGuardianName(toUpper(clientMasterDto.getGuardianName()));
		addcustomer.setCustomerGender(toUpper(clientMasterDto.getCustomerGender()));
		addcustomer.setDob(clientMasterDto.getDob());
		addcustomer.setCustomerAge(clientMasterDto.getCustomerAge());
		addcustomer.setRelationshipStatus(toUpper(clientMasterDto.getRelationshipStatus()));
		addcustomer.setCustomerAddress(toUpper(clientMasterDto.getCustomerAddress()));
		addcustomer.setDistrict(toUpper(clientMasterDto.getDistrict()));
		addcustomer.setState(toUpper(clientMasterDto.getState()));
		addcustomer.setBranchName(toUpper(clientMasterDto.getBranchName()));
		addcustomer.setPinCode(toUpper(clientMasterDto.getPinCode()));
		addcustomer.setAadharNo(toUpper(clientMasterDto.getAadharNo()));
		addcustomer.setPanNo(toUpper(clientMasterDto.getPanNo()));
		addcustomer.setVoterNo(toUpper(clientMasterDto.getVoterNo()));
		addcustomer.setContactNo(toUpper(clientMasterDto.getContactNo()));
		addcustomer.setMinor(toUpper(clientMasterDto.getMinor()));
		addcustomer.setEmailId(toUpper(clientMasterDto.getEmailId()));
		addcustomer.setProfession(toUpper(clientMasterDto.getProfession()));
		addcustomer.setOccupation(toUpper(clientMasterDto.getOccupation()));
		addcustomer.setEducation(toUpper(clientMasterDto.getEducation()));
		addcustomer.setMonthlyIncome(toUpper(clientMasterDto.getMonthlyIncome()));
		addcustomer.setReferralCode(toUpper(clientMasterDto.getReferralCode()));
		addcustomer.setReferralName(toUpper(clientMasterDto.getReferralName()));
		addcustomer.setDrivingLicenceNo(toUpper(clientMasterDto.getDrivingLicenceNo()));
		addcustomer.setShareAmount(toUpper(clientMasterDto.getShareAmount()));
		addcustomer.setNoOfShare(toUpper(clientMasterDto.getNoOfShare()));
		addcustomer.setLightBill(toUpper(clientMasterDto.getLightBill()));
		addcustomer.setTaxBill(toUpper(clientMasterDto.getTaxBill()));
		addcustomer.setInterestPercent(toUpper(clientMasterDto.getInterestPercent()));
		addcustomer.setFirstName(toUpper(clientMasterDto.getFirstName()));
		addcustomer.setMiddleName(toUpper(clientMasterDto.getMiddleName()));
		addcustomer.setLastName(toUpper(clientMasterDto.getLastName()));
		addcustomer.setGuardianAccountNo(toUpper(clientMasterDto.getGuardianAccountNo()));
		addcustomer.setCategory(toUpper(clientMasterDto.getCategory()));
		addcustomer.setCaste(toUpper(clientMasterDto.getCaste()));
		addcustomer.setShareValue(toUpper(clientMasterDto.getShareValue()));

		// Nominee Details
		addcustomer.setNomineeName(toUpper(clientMasterDto.getNomineeName()));
		addcustomer.setNomineeAddress(toUpper(clientMasterDto.getNomineeAddress()));
		addcustomer.setNomineeKycNo(toUpper(clientMasterDto.getNomineeKycNo()));
		addcustomer.setNomineeMobileNo(toUpper(clientMasterDto.getNomineeMobileNo()));
		addcustomer.setNomineeAge(toUpper(clientMasterDto.getNomineeAge()));
		addcustomer.setNomineePanNo(toUpper(clientMasterDto.getNomineePanNo()));
		addcustomer.setNomineeKycType(toUpper(clientMasterDto.getNomineeKycType()));
		addcustomer.setNomineeDOB(clientMasterDto.getNomineeDOB());

		// Payment details
		addcustomer.setMemberFees(toUpper(clientMasterDto.getMemberFees()));
		addcustomer.setBuildingFund(toUpper(clientMasterDto.getBuildingFund()));
		addcustomer.setAdminCharge(toUpper(clientMasterDto.getAdminCharge()));
		addcustomer.setDocumentCharge(clientMasterDto.getDocumentCharge());

		addcustomer.setOtherCharge(clientMasterDto.getOtherCharge());
		addcustomer.setChequeNo(clientMasterDto.getChequeNo());
		addcustomer.setChequeDate(clientMasterDto.getChequeDate());
		addcustomer.setDepositAcNo(clientMasterDto.getDepositAcNo());
		addcustomer.setReferenceNo(clientMasterDto.getReferenceNo());
		addcustomer.setRemarks(clientMasterDto.getRemarks());
		addcustomer.setPaymentBy(clientMasterDto.getPaymentBy());

		// Additional
		addcustomer.setMobileBanking(clientMasterDto.getMobileBanking());
		addcustomer.setSmsSend(clientMasterDto.getSmsSend());
		addcustomer.setMemberStatus(clientMasterDto.getMemberStatus());
		addcustomer.setNetBanking(clientMasterDto.getNetBanking());

		// Handle File Uploads
		try {
			if (customerAadharImage != null && !customerAadharImage.isEmpty()) {
				String aadharImageFileName = saveFile(customerAadharImage);
				addcustomer.setCustomerAadharImage(aadharImageFileName);
			}

			if (customerPanImage != null && !customerPanImage.isEmpty()) {
				String panImageFileName = saveFile(customerPanImage);
				addcustomer.setCustomerPanImage(panImageFileName);
			}

			if (customerVoter != null && !customerVoter.isEmpty()) {
				String voterFileName = saveFile(customerVoter);
				addcustomer.setCustomerVoter(voterFileName);
			}

			if (customerPhoto != null && !customerPhoto.isEmpty()) {
				String photoFileName = saveFile(customerPhoto);
				addcustomer.setCustomerPhoto(photoFileName);
			}

			if (nomineAadhar != null && !nomineAadhar.isEmpty()) {
				String nomineAadharFileName = saveFile(nomineAadhar);
				addcustomer.setNomineAadhar(nomineAadharFileName);
			}

			if (nomineSignature != null && !nomineSignature.isEmpty()) {
				String nomineSignatureFileName = saveFile(nomineSignature);
				addcustomer.setNomineSignature(nomineSignatureFileName);
			}

			if (customerSignature != null && !customerSignature.isEmpty()) {
				String signatureFileName = saveFile(customerSignature);
				addcustomer.setCustomerSignature(signatureFileName);
			}
		} catch (IOException e) {
			return ApiResponse.error(HttpStatus.INTERNAL_SERVER_ERROR, "File upload failed: " + e.getMessage());
		}

		// Save entity
		addCustomer saved = customerRepo.save(addcustomer);

		if (isNew) {
			CreateSavingsAccount createdAccount = autoCreateSavingsAccount(saved);

			// Send email notification with member code and account details
			String accountNumber = (createdAccount != null) ? createdAccount.getAccountNumber() : null;
			sendAccountCreationEmail(saved.getEmailId(), saved.getCustomerName(), saved.getMemberCode(), accountNumber);


			// Build a unified response with matched fields from both tables
			Map<String, Object> responseData = new HashMap<>();
			responseData.put("id", saved.getId());
			responseData.put("customerId", saved.getId());
			responseData.put("memberCode", saved.getMemberCode());
			responseData.put("customerName", saved.getCustomerName());
			responseData.put("contactNo", saved.getContactNo());
			responseData.put("branchName", saved.getBranchName());
			responseData.put("signupDate", saved.getSignupDate());
			if (createdAccount != null) {
				responseData.put("savingAccountNumber", createdAccount.getAccountNumber());
				responseData.put("accountType", createdAccount.getTypeofaccount());
				responseData.put("accountStatus", createdAccount.getAccountStatus());
				responseData.put("accountMemberCode", createdAccount.getSelectByCustomer());
				responseData.put("accountCustomerName", createdAccount.getEnterCustomerName());
				responseData.put("accountBalance", createdAccount.getBalance());
				responseData.put("isApproved", createdAccount.isApproved());
			} else {
				responseData.put("savingAccountNumber", null);
				responseData.put("accountCreationNote", "Saving account could not be auto-created. Please check logs.");
			}
			return ApiResponse.success(HttpStatus.CREATED,
					"Customer saved successfully. Member Code: " + saved.getMemberCode() +
					(createdAccount != null ? " | Account No: " + createdAccount.getAccountNumber() : ""),
					responseData);
		} else {
			return ApiResponse.success(HttpStatus.OK,
					"Customer updated successfully. Member Code: " + saved.getMemberCode(), saved);
		}
	}

	private CreateSavingsAccount autoCreateSavingsAccount(addCustomer savedCustomer) {
		try {
			// Guard: skip if member code is missing
			if (savedCustomer.getMemberCode() == null || savedCustomer.getMemberCode().trim().isEmpty()) {
				System.err.println("Skipping auto savings account creation: memberCode is null for customer ID "
						+ savedCustomer.getId());
				return null;
			}
			// Guard: skip if customer name is missing
			if (savedCustomer.getCustomerName() == null || savedCustomer.getCustomerName().trim().isEmpty()) {
				System.err.println("Skipping auto savings account creation: customerName is null for memberCode: " + savedCustomer.getMemberCode());
				return null;
			}
			// Guard: skip if savings account already exists for this member
			if (createSavingAccountRepo.existsBySelectByCustomer(savedCustomer.getMemberCode())) {
				System.out.println("Savings account already exists for memberCode: " + savedCustomer.getMemberCode());
				// Return existing account so response still includes account number
				List<CreateSavingsAccount> existingAccounts = createSavingAccountRepo.findBySelectByCustomer(savedCustomer.getMemberCode());
				return existingAccounts.isEmpty() ? null : existingAccounts.get(0);
			}
			CreateSavingsAccount account = new CreateSavingsAccount();
			account.setTypeofaccount("savingaccount");
			account.setOpeningDate(savedCustomer.getSignupDate());

			// ✅ Linking: memberCode from add_customer → selectByCustomer in create_savings_account
			account.setSelectByCustomer(savedCustomer.getMemberCode());
			// ✅ Linking: customerName from add_customer → enterCustomerName in create_savings_account
			account.setEnterCustomerName(savedCustomer.getCustomerName());

			account.setDateOfBirth(savedCustomer.getDob());
			account.setFamilyDetails(savedCustomer.getGuardianName());
			account.setContactNumber(savedCustomer.getContactNo());
			account.setSuggestedNomineeName(savedCustomer.getNomineeName());
			account.setSuggestedNomineeAge(savedCustomer.getNomineeAge());
			account.setSuggestedNomineeRelation(savedCustomer.getNomineeRelationToApplicant());
			account.setAddress(savedCustomer.getCustomerAddress());
			account.setDistrict(savedCustomer.getDistrict());
			account.setState(savedCustomer.getState());
			account.setPinCode(savedCustomer.getPinCode());
			account.setEmailId(savedCustomer.getEmailId());
			account.setAadharNo(savedCustomer.getAadharNo());
			account.setAuthenticateWith(null);

			if (savedCustomer.getBranchName() != null && !savedCustomer.getBranchName().trim().isEmpty()) {
				try {
					String customerBranch = savedCustomer.getBranchName().trim();
					List<BranchModule> allBranches = branchModuleRepo.findAll();

					// 1st: exact case-insensitive match
					BranchModule matched = allBranches.stream()
							.filter(b -> customerBranch.equalsIgnoreCase(b.getBranchName()))
							.findFirst()
							// 2nd fallback: contains match (e.g. "NAGPUR" matches "Nagpur Branch")
							.orElseGet(() -> allBranches.stream()
									.filter(b -> b.getBranchName() != null &&
											b.getBranchName().toLowerCase().contains(customerBranch.toLowerCase()))
									.findFirst()
									.orElse(null));

					if (matched != null) {
						account.setBranchName(matched);
						System.out.println("Branch matched: " + matched.getBranchName() + " for customer branch: " + customerBranch);
					} else {
						System.err.println("No branch found for: " + customerBranch);
					}
				} catch (Exception branchEx) {
					System.err.println("Branch lookup failed: " + branchEx.getMessage());
				}
			}

			account.setOperationType("Single");
			String initialBalance = (savedCustomer.getMemberFees() != null && !savedCustomer.getMemberFees().trim().isEmpty())
					? savedCustomer.getMemberFees().trim()
					: "0";
			account.setBalance(initialBalance);
			account.setOpeningFees("0");
			account.setAccountStatus("1");
			account.setAccountFreeze("0");
			account.setModeOfPayment("Cash");
			account.setApproved(false);

			account.setPhoto(savedCustomer.getCustomerPhoto());
			account.setSignature(savedCustomer.getCustomerSignature());

			long maxId = createSavingAccountRepo.getMaxId();
			String accountNumber = String.format("2025%08d", maxId + 1);
			account.setAccountNumber(accountNumber);

			CreateSavingsAccount savedAccount = createSavingAccountRepo.save(account);

			System.out.println("✅ Auto-created savings account | MemberCode: " + savedCustomer.getMemberCode()
					+ " | CustomerName: " + savedCustomer.getCustomerName()
					+ " | AccountNumber: " + accountNumber);

			return savedAccount;
		} catch (Exception e) {
			System.err.println("Failed to auto-create savings account for customer: " + e.getMessage());
			e.printStackTrace();
			return null;
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
		List<addCustomer> list = customerRepo.findAll();
		for (addCustomer c : list) {
			if (c.getDepositAcNo() == null || c.getDepositAcNo().trim().isEmpty()) {
				if (c.getMemberCode() != null && !c.getMemberCode().trim().isEmpty()) {
					List<CreateSavingsAccount> accounts = createSavingAccountRepo.findBySelectByCustomer(c.getMemberCode());
					if (!accounts.isEmpty() && accounts.get(0).getAccountNumber() != null) {
						c.setDepositAcNo(accounts.get(0).getAccountNumber());
					}
				}
			}
		}
		return list;
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

	public static class ExtraImageDto {
		private Long id;
		private String name;
		private String fileName;
		private String originalFileName;
		private String uploadDate;

		public ExtraImageDto() {
		}

		public ExtraImageDto(Long id, String name, String fileName, String originalFileName, String uploadDate) {
			this.id = id;
			this.name = name;
			this.fileName = fileName;
			this.originalFileName = originalFileName;
			this.uploadDate = uploadDate;
		}

		public Long getId() {
			return id;
		}

		public void setId(Long id) {
			this.id = id;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public String getFileName() {
			return fileName;
		}

		public void setFileName(String fileName) {
			this.fileName = fileName;
		}

		public String getOriginalFileName() {
			return originalFileName;
		}

		public void setOriginalFileName(String originalFileName) {
			this.originalFileName = originalFileName;
		}

		public String getUploadDate() {
			return uploadDate;
		}

		public void setUploadDate(String uploadDate) {
			this.uploadDate = uploadDate;
		}
	}

	private List<ExtraImageDto> parseExtraImages(String json) {
		if (json == null || json.trim().isEmpty()) {
			return new ArrayList<>();
		}
		try {
			ObjectMapper mapper = new ObjectMapper();
			return mapper.readValue(json, new TypeReference<List<ExtraImageDto>>() {
			});
		} catch (Exception e) {
			e.printStackTrace();
			return new ArrayList<>();
		}
	}

	private String serializeExtraImages(List<ExtraImageDto> list) {
		try {
			ObjectMapper mapper = new ObjectMapper();
			return mapper.writeValueAsString(list);
		} catch (Exception e) {
			e.printStackTrace();
			return "[]";
		}
	}

	public ExtraImageDto saveOrUpdateCustomerImage(Long customerId, String fieldName, MultipartFile file)
			throws Exception {

		addCustomer customer = customerRepo.findById(customerId)
				.orElseThrow(() -> new IllegalArgumentException("Invalid Customer ID: " + customerId));

		Path customerDir = Paths.get(uploadDirectory, "customer", customerId.toString());
		Files.createDirectories(customerDir);

		String originalFilename = StringUtils.cleanPath(file.getOriginalFilename());
		String storedFileName = System.currentTimeMillis() + "_" + originalFilename;

		Path target = customerDir.resolve(storedFileName);
		Files.copy(file.getInputStream(), target, StandardCopyOption.REPLACE_EXISTING);

		List<ExtraImageDto> images = parseExtraImages(customer.getCustomerExtraImage());

		ExtraImageDto targetImg = null;
		for (ExtraImageDto img : images) {
			if (img.getName().equalsIgnoreCase(fieldName)) {
				targetImg = img;
				break;
			}
		}

		String currentDateTime = java.time.LocalDateTime.now()
				.format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

		if (targetImg != null) {
			if (targetImg.getFileName() != null) {
				Files.deleteIfExists(customerDir.resolve(targetImg.getFileName()));
			}
			targetImg.setFileName(storedFileName);
			targetImg.setOriginalFileName(originalFilename);
			targetImg.setUploadDate(currentDateTime);
		} else {
			long newId = System.currentTimeMillis();
			targetImg = new ExtraImageDto(newId, fieldName, storedFileName, originalFilename, currentDateTime);
			images.add(targetImg);
		}

		customer.setCustomerExtraImage(serializeExtraImages(images));
		customerRepo.save(customer);

		return targetImg;
	}

	public List<ExtraImageDto> getCustomerImages(Long customerId) {
		addCustomer customer = customerRepo.findById(customerId).orElse(null);
		if (customer == null) {
			return new ArrayList<>();
		}
		return parseExtraImages(customer.getCustomerExtraImage());
	}

	public boolean deleteCustomerImage(String compositeId) {
		if (compositeId == null || !compositeId.contains("-")) {
			return false;
		}
		String[] parts = compositeId.split("-");
		if (parts.length < 2) {
			return false;
		}
		Long customerId;
		Long imageId;
		try {
			customerId = Long.parseLong(parts[0]);
			imageId = Long.parseLong(parts[1]);
		} catch (NumberFormatException e) {
			return false;
		}

		Optional<addCustomer> opt = customerRepo.findById(customerId);
		if (!opt.isPresent()) {
			return false;
		}

		addCustomer customer = opt.get();
		List<ExtraImageDto> images = parseExtraImages(customer.getCustomerExtraImage());

		ExtraImageDto targetImg = null;
		int targetIndex = -1;
		for (int i = 0; i < images.size(); i++) {
			if (images.get(i).getId().equals(imageId)) {
				targetImg = images.get(i);
				targetIndex = i;
				break;
			}
		}

		if (targetIndex == -1) {
			return false;
		}

		Path customerDir = Paths.get(uploadDirectory, "customer", customerId.toString());
		try {
			if (targetImg.getFileName() != null) {
				Files.deleteIfExists(customerDir.resolve(targetImg.getFileName()));
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		images.remove(targetIndex);
		customer.setCustomerExtraImage(serializeExtraImages(images));
		customerRepo.save(customer);

		return true;
	}

	private void sendAccountCreationEmail(String emailId, String customerName, String memberCode, String accountNumber) {
		if (emailId == null || emailId.trim().isEmpty()) {
			System.out.println("Skipping email notification: No email address provided for " + customerName);
			return;
		}
		CompletableFuture.runAsync(() -> {
			try {
				SimpleMailMessage message = new SimpleMailMessage();
				message.setFrom("yyeskar@gmail.com");
				message.setTo(emailId);
				message.setSubject("Welcome to Samitha Urban Nidhi Limited!");
				message.setText("Dear " + customerName + ",\n\n" +
						"We are absolutely thrilled to welcome you to the Samitha Urban family! Thank you for choosing us as your trusted financial partner.\n\n" +
						"It is our privilege to help you achieve your financial goals. Your customer profile has been successfully set up, and we have opened your new Savings Account.\n\n" +
						"Below are your account credentials for your reference:\n" +
						"--------------------------------------------------\n" +
						"Customer Member Code : " + memberCode + "\n" +
						"Savings Account No.  : " + (accountNumber != null ? accountNumber : "N/A") + "\n" +
						"--------------------------------------------------\n\n" +
						"We are committed to providing you with the highest standard of service, secure banking, and convenient financial solutions. You can manage your account and access our services at your nearest branch.\n\n" +
						"Should you have any questions or require any assistance, please do not hesitate to contact our customer support team.\n\n" +
						"Once again, welcome aboard, and we look forward to a long and successful relationship with you!\n\n" +
						"Warm regards,\n\n" +
						"Customer Relations Team\n" +
						"Samitha Urban Nidhi Limited");
				mailSender.send(message);
				System.out.println("✅ Email sent successfully to " + emailId);
			} catch (Exception e) {
				System.err.println("Failed to send email to " + emailId + ": " + e.getMessage());
				e.printStackTrace();
			}
		});
	}

	private String toUpper(String str) {
		return str == null ? null : str.trim().toUpperCase();
	}
}