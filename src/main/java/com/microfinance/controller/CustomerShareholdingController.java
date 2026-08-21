package com.microfinance.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.microfinance.dto.ApiResponse;
import com.microfinance.model.BranchModule;
import com.microfinance.model.TransferShare;
import com.microfinance.model.addCustomer;
import com.microfinance.service.CustomerShareholdingService;

@RestController
@RequestMapping("/api/customershareholdingcontroller")
public class CustomerShareholdingController {

	@Autowired
	CustomerShareholdingService customershareholdingservice;

//Transfer Share - Oshin Dongre (12-06-2025)----------------------------------------------------------------------------------------
	
	// Find CustomerCode
	@GetMapping("/findAllCustomerCode")
	public ApiResponse<List<addCustomer>> findByCustomerCode() {
		List<addCustomer> list = customershareholdingservice.findByCustomerCode();
		if (list != null && !list.isEmpty()) {
			return ApiResponse.success(HttpStatus.OK, "Transfer Share List Find Successfully", list);
		} else {
			return ApiResponse.error(HttpStatus.NOT_FOUND, "Transfer Share Data List is not Found");
		}
	}

	// fetch Customer Code
	@RequestMapping(value = "/fetchByCustomerCode", method = {RequestMethod.GET, RequestMethod.POST})
	public ApiResponse<List<addCustomer>> fetchByCustomerCode(@RequestParam("memberCode") String memberCode) {
		List<addCustomer> list = customershareholdingservice.fetchByCustomerCode(memberCode);
		if (list != null && !list.isEmpty()) {
			return ApiResponse.success(HttpStatus.OK, "Transfer Share Fetched Successfully", list);
		} else {
			return ApiResponse.error(HttpStatus.NOT_FOUND, "Transfer Share Not Found");
		}
	}

	// Find Branch
	@GetMapping("/findAllBranch")
	public ApiResponse<List<BranchModule>> findByBranch() {
		List<BranchModule> list = customershareholdingservice.findByBranch();
		if (list != null && !list.isEmpty()) {
			return ApiResponse.success(HttpStatus.OK, "Branch List Find Successfully", list);
		} else {
			return ApiResponse.error(HttpStatus.NOT_FOUND, "Branch Data List is not Found");
		}
	}
	
	// Save Code
	@PostMapping("/saveTransferShare")
	public ResponseEntity<ApiResponse<TransferShare>> saveTransferShare(@RequestBody TransferShare transfer) {
		TransferShare saveTS = customershareholdingservice.saveAllTransferShare(transfer);
		if (saveTS != null) {
			ApiResponse<TransferShare> response = ApiResponse.success(HttpStatus.OK, "Transfer Share Data SAVED successfully", saveTS);
			return ResponseEntity.ok(response);
		} else {
			ApiResponse<TransferShare> errorResponse = ApiResponse.error(HttpStatus.INTERNAL_SERVER_ERROR, "Transfer Share Data not SAVED");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
		}
	}

	// All Data Show in Table
	@GetMapping("/allDataFetchTransferShareInTable")
	public ResponseEntity<ApiResponse<List<TransferShare>>> allDataFetchTransferShareInTable() {
		List<TransferShare> list = customershareholdingservice.allDataFetchTransferShareInTable();

		if (list != null && !list.isEmpty()) {
			ApiResponse<List<TransferShare>> response = new ApiResponse<>(HttpStatus.OK, "Transfer Share All Data Shown Successfully", list);
			return ResponseEntity.ok(response);
		} else {
			ApiResponse<List<TransferShare>> response = new ApiResponse<>(HttpStatus.OK, "No Transfer Share Data Found", java.util.Collections.emptyList());
			return ResponseEntity.ok(response);
		}
	}

	// Edit Code
	@GetMapping("/getTransferShareIdEdite")    
	public ResponseEntity<ApiResponse<TransferShare>> getTransferShareIdEdite(@RequestParam Long id) {
	    TransferShare ts = customershareholdingservice.getTransferShareIdEdite(id); 
	    
	    if (ts != null) {
	        ApiResponse<TransferShare> response = new ApiResponse<>(HttpStatus.OK, "Transfer Share Data Edit Successfully", ts);
	        return ResponseEntity.ok(response);
	    } else {
	        ApiResponse<TransferShare> response = new ApiResponse<>(HttpStatus.NOT_FOUND, "Transfer Share Data is Not Found : " + id, null);
	        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
	    }
	}

	// update code 
	@PostMapping("/updateTransferShare")
	public ResponseEntity<ApiResponse<TransferShare>> updateTransferShare(@RequestBody TransferShare transfer) {
		TransferShare updateTS = customershareholdingservice.updateTransferShare(transfer);
		if (updateTS != null) {
			ApiResponse<TransferShare> response = ApiResponse.success(HttpStatus.OK, "Transfer Share Data Update successfully", updateTS);
			return ResponseEntity.ok(response);
		} else {
			ApiResponse<TransferShare> errorResponse = ApiResponse.error(HttpStatus.INTERNAL_SERVER_ERROR, "Transfer Share Data not Update");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
		}
	}

	// Delete By Id
	@RequestMapping(value = "/deleteTransferShareById", method = {RequestMethod.GET, RequestMethod.POST, RequestMethod.DELETE})
	public ResponseEntity<ApiResponse<TransferShare>> deleteTransferShareById(@RequestParam Long id) {
		boolean deleted = customershareholdingservice.deleteTransferShareById(id);

		if (deleted) {
			ApiResponse<TransferShare> response = new ApiResponse<>(HttpStatus.OK, "Transfer Share Data Delete Successfully", null);
	        return ResponseEntity.ok(response);		
		} else {
			ApiResponse<TransferShare> response = ApiResponse.error(HttpStatus.NOT_FOUND, "Transfer Share Data is Not Delete, because It's Not Found");
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
		}
	}

// End TransferShare Sub Model -----------------------------------------------------------------------------------------------------

//UnAllotedShare - Oshin Dongre (25-06-2025)----------------------------------------------------------------------------------------
	
	// Find List Of TransferShare
	@GetMapping("/findAllTransferShare")
	public ApiResponse<List<TransferShare>> findByTransferShare() {
		List<TransferShare> list = customershareholdingservice.findByTransferShare();
		if (list != null && !list.isEmpty()) {
			return ApiResponse.success(HttpStatus.OK, "UnAllotedShare List Find Successfully", list);
		} else {
			return ApiResponse.error(HttpStatus.NOT_FOUND, "UnAllotedShare Data List is not Found");
		}
	}	

	//Fetch By Find By Code 
	@RequestMapping(value = "/fetchByFindByCode", method = {RequestMethod.GET, RequestMethod.POST})
	public ApiResponse<List<TransferShare>> fetchByTransferShare(@RequestParam(value = "findByCode", required = false) String findByCode) {
		List<TransferShare> list = customershareholdingservice.fetchByTransferShare(findByCode);
		if (list != null && !list.isEmpty()) {
			return ApiResponse.success(HttpStatus.OK, "Transfer Share Fetched Successfully", list);
		} else {
			return ApiResponse.error(HttpStatus.NOT_FOUND, "Transfer Share Not Found");
		}
	}

// End UnAllotedShare Sub Model -----------------------------------------------------------------------------------------------------	
		
// Generate Share Certificate - Oshin Dongre (25-06-2025)---------------------------------------------------------------------------------------
		
	// Find List Of TransferShare
	@GetMapping("/getAllTransferShare")
	public ApiResponse<List<TransferShare>> getAllTransferShare() {
		List<TransferShare> list = customershareholdingservice.getAllTransferShare();
		if (list != null && !list.isEmpty()) {
			return ApiResponse.success(HttpStatus.OK, "Share Certificate List Find Successfully", list);
		} else {
			return ApiResponse.error(HttpStatus.NOT_FOUND, "Share Certificate Data List is not Found");
		}
	}

	// fetch A table 
	@RequestMapping(value = "/fetchByCertificateNo", method = {RequestMethod.GET, RequestMethod.POST})
	public ApiResponse<List<TransferShare>> fetchByCertificateNo(@RequestParam(value = "findByCode", required = false) String findByCode) {
		List<TransferShare> list = customershareholdingservice.fetchByCertificateNo(findByCode);
		if (list != null && !list.isEmpty()) {
			return ApiResponse.success(HttpStatus.OK, "Transfer Share Fetched Successfully", list);
		} else {
			return ApiResponse.error(HttpStatus.NOT_FOUND, "Transfer Share Not Found");
		}
	}

// End Generate Share Certificate Sub Model -----------------------------------------------------------------------------------------------------
}