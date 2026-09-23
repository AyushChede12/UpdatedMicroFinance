package com.microfinance.controller;

import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.microfinance.dto.ApiResponse;
import com.microfinance.dto.CustomerLookupDto;
import com.microfinance.model.addCustomer;
import com.microfinance.repository.CustomerRepo;

@RestController
@RequestMapping("/api/customer")
public class CustomerLookupController {

	@Autowired
	private CustomerRepo customerRepo;

	@GetMapping("/{code}")
	public ResponseEntity<ApiResponse<CustomerLookupDto>> getCustomerByCode(@PathVariable("code") String code) {
		if (code == null || code.trim().isEmpty()) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST)
					.body(ApiResponse.error(HttpStatus.BAD_REQUEST, "Customer code cannot be empty"));
		}

		Optional<addCustomer> opt = customerRepo.findByMemberCode(code.trim());
		if (!opt.isPresent()) {
			// Try case-insensitive or list search fallback
			java.util.List<addCustomer> list = customerRepo.findBymemberCode(code.trim());
			if (list != null && !list.isEmpty()) {
				opt = Optional.of(list.get(0));
			}
		}

		if (!opt.isPresent()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND)
					.body(ApiResponse.error(HttpStatus.NOT_FOUND, "Customer not found with code: " + code));
		}

		addCustomer c = opt.get();

		String identityType = "Aadhar";
		String identityNum = c.getAadharNo();
		if ((identityNum == null || identityNum.trim().isEmpty()) && c.getPanNo() != null && !c.getPanNo().trim().isEmpty()) {
			identityType = "PAN";
			identityNum = c.getPanNo();
		} else if (identityNum == null || identityNum.trim().isEmpty()) {
			identityNum = "";
		}

		String name = c.getCustomerName();
		if (name == null || name.trim().isEmpty()) {
			// check first, middle, last name if available
			name = c.getMemberCode();
		}

		CustomerLookupDto dto = new CustomerLookupDto(
				c.getMemberCode(),
				name,
				identityType,
				identityNum,
				c.getCustomerAddress(),
				c.getPinCode(),
				c.getContactNo(),
				c.getCustomerAge()
		);

		return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "Customer details fetched successfully", dto));
	}
}
