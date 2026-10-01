package com.microfinance.controller;

import com.microfinance.dto.ApiResponse;
import com.microfinance.dto.GroupLoanApplicationDto;
import com.microfinance.dto.GroupLoanApprovalDetailsDto;
import com.microfinance.dto.GroupLoanApprovalDto;
import com.microfinance.dto.GroupLoanDropdownDto;
import com.microfinance.dto.GroupProfileDto;
import com.microfinance.model.GroupLoanApplication;
import com.microfinance.service.GroupLoanApplicationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@CrossOrigin(origins = "*")
public class GroupLoanController {

    @Autowired
    private GroupLoanApplicationService groupLoanApplicationService;

    @GetMapping("/api/groups")
    public ResponseEntity<ApiResponse<List<GroupLoanDropdownDto>>> getGroupDropdownList() {
        try {
            List<GroupLoanDropdownDto> list = groupLoanApplicationService.getGroupDropdownList();
            return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "Groups fetched successfully", list));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(ApiResponse.error(HttpStatus.INTERNAL_SERVER_ERROR, "Error fetching groups: " + e.getMessage()));
        }
    }

    @GetMapping("/api/groups/{groupCode}")
    public ResponseEntity<ApiResponse<GroupProfileDto>> getGroupProfile(@PathVariable("groupCode") String groupCode) {
        try {
            GroupProfileDto profile = groupLoanApplicationService.getGroupProfile(groupCode);
            return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "Group profile fetched successfully", profile));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(ApiResponse.error(HttpStatus.NOT_FOUND, e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(ApiResponse.error(HttpStatus.INTERNAL_SERVER_ERROR, "Error fetching group profile: " + e.getMessage()));
        }
    }

    @PostMapping({"/api/grouploans", "/api/groups/apply"})
    public ResponseEntity<ApiResponse<?>> applyGroupLoan(
            @Valid @RequestBody GroupLoanApplicationDto dto,
            BindingResult bindingResult) {

        if (bindingResult.hasErrors()) {
            String errorMsg = bindingResult.getFieldErrors().stream()
                    .map(FieldError::getDefaultMessage)
                    .collect(Collectors.joining("; "));
            return ResponseEntity.badRequest().body(ApiResponse.error(HttpStatus.BAD_REQUEST, errorMsg));
        }

        try {
            GroupLoanApplication saved = groupLoanApplicationService.saveGroupLoanApplication(dto);
            return ResponseEntity.status(HttpStatus.CREATED)
                    .body(ApiResponse.success(HttpStatus.CREATED, "Group loan application created successfully with No: " + saved.getApplicationNo(), saved));
        } catch (IllegalStateException e) {
            return ResponseEntity.status(HttpStatus.CONFLICT)
                    .body(ApiResponse.error(HttpStatus.CONFLICT, e.getMessage()));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(ApiResponse.error(HttpStatus.BAD_REQUEST, e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(ApiResponse.error(HttpStatus.INTERNAL_SERVER_ERROR, "Server error: " + e.getMessage()));
        }
    }

    @GetMapping("/api/grouploans")
    public ResponseEntity<ApiResponse<List<GroupLoanApplication>>> getAllGroupLoanApplications() {
        try {
            List<GroupLoanApplication> list = groupLoanApplicationService.getAllApplications();
            return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "Applications fetched successfully", list));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(ApiResponse.error(HttpStatus.INTERNAL_SERVER_ERROR, "Error fetching applications: " + e.getMessage()));
        }
    }

    @DeleteMapping({"/api/grouploans", "/api/grouploans/all"})
    public ResponseEntity<ApiResponse<String>> deleteAllGroupLoans() {
        try {
            groupLoanApplicationService.deleteAllGroupLoans();
            return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "All group loan data deleted successfully", null));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(ApiResponse.error(HttpStatus.INTERNAL_SERVER_ERROR, "Error deleting group loan data: " + e.getMessage()));
        }
    }

    @GetMapping("/api/grouploans/approvals/list")
    public ResponseEntity<ApiResponse<List<Map<String, Object>>>> getApplicationsForApprovalDropdown() {
        try {
            List<Map<String, Object>> list = groupLoanApplicationService.getApplicationsForApprovalDropdown();
            return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "Applications fetched successfully", list));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(ApiResponse.error(HttpStatus.INTERNAL_SERVER_ERROR, "Error fetching applications: " + e.getMessage()));
        }
    }

    @GetMapping("/api/grouploans/approvals/details/{identifier}")
    public ResponseEntity<ApiResponse<GroupLoanApprovalDetailsDto>> getApplicationApprovalDetails(
            @PathVariable("identifier") String identifier) {
        try {
            GroupLoanApprovalDetailsDto details = groupLoanApplicationService.getApplicationApprovalDetails(identifier);
            return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "Application details fetched successfully", details));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(ApiResponse.error(HttpStatus.NOT_FOUND, e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(ApiResponse.error(HttpStatus.INTERNAL_SERVER_ERROR, "Error fetching application details: " + e.getMessage()));
        }
    }

    @PostMapping("/api/grouploans/approvals/process")
    public ResponseEntity<ApiResponse<GroupLoanApprovalDetailsDto>> processLoanApproval(
            @RequestBody GroupLoanApprovalDto dto) {
        try {
            GroupLoanApprovalDetailsDto updated = groupLoanApplicationService.processLoanApproval(dto);
            String action = dto.getAction() != null ? dto.getAction().toUpperCase() : "PROCESSED";
            return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "Group loan application " + action + " successfully.", updated));
        } catch (IllegalStateException e) {
            return ResponseEntity.status(HttpStatus.CONFLICT)
                    .body(ApiResponse.error(HttpStatus.CONFLICT, e.getMessage()));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(ApiResponse.error(HttpStatus.BAD_REQUEST, e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(ApiResponse.error(HttpStatus.INTERNAL_SERVER_ERROR, "Error processing loan approval: " + e.getMessage()));
        }
    }

    @PostMapping("/api/grouploans/approvals/reset/{identifier}")
    public ResponseEntity<ApiResponse<GroupLoanApprovalDetailsDto>> resetLoanApproval(
            @PathVariable("identifier") String identifier) {
        try {
            GroupLoanApprovalDetailsDto updated = groupLoanApplicationService.resetToPending(identifier);
            return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "Application status reset to PENDING.", updated));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(ApiResponse.error(HttpStatus.INTERNAL_SERVER_ERROR, "Error resetting status: " + e.getMessage()));
        }
    }
}
