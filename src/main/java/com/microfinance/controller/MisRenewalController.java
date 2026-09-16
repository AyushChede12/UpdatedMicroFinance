package com.microfinance.controller;

import com.microfinance.dto.*;
import com.microfinance.model.MisClosureAudit;
import com.microfinance.model.MisPayoutLedger;
import com.microfinance.model.MisPolicy;
import com.microfinance.service.MisRenewalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * MisRenewalController — REST API for the MIS Renewal module.
 * Base path: /api/mis
 *
 * Does NOT conflict with existing PolicyManagementController (/api/Policymangment).
 */
@RestController
@RequestMapping("/api/mis")
public class MisRenewalController {

    @Autowired
    private MisRenewalService misRenewalService;

    // ──────────────────────────────────────────────────────────────────────
    //  GET all policies
    // ──────────────────────────────────────────────────────────────────────
    @GetMapping("/policies")
    public ResponseEntity<ApiResponse<List<MisPolicyResponseDto>>> getAllPolicies() {
        List<MisPolicyResponseDto> list = misRenewalService.getAllPolicies();
        return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "MIS policies fetched.", list));
    }

    // ──────────────────────────────────────────────────────────────────────
    //  POST create policy directly (also called internally from investment save)
    // ──────────────────────────────────────────────────────────────────────
    @PostMapping("/policies")
    public ResponseEntity<ApiResponse<MisPolicyResponseDto>> createPolicy(
            @RequestBody MisPolicyRequestDto req) {
        MisPolicy policy = misRenewalService.createMisPolicy(req);
        MisPolicyResponseDto dto = misRenewalService.toDto(policy);
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(HttpStatus.CREATED, "MIS Policy created: " + policy.getPolicyNumber(), dto));
    }

    // ──────────────────────────────────────────────────────────────────────
    //  GET policy by ID
    // ──────────────────────────────────────────────────────────────────────
    @GetMapping("/policies/{id}")
    public ResponseEntity<ApiResponse<MisPolicyResponseDto>> getPolicyById(@PathVariable Long id) {
        MisPolicyResponseDto dto = misRenewalService.getPolicyById(id);
        return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "MIS Policy fetched.", dto));
    }

    // ──────────────────────────────────────────────────────────────────────
    //  GET policies by customer
    // ──────────────────────────────────────────────────────────────────────
    @GetMapping("/policies/customer/{customerId}")
    public ResponseEntity<ApiResponse<List<MisPolicyResponseDto>>> getPoliciesByCustomer(
            @PathVariable String customerId) {
        List<MisPolicyResponseDto> list = misRenewalService.getPoliciesByCustomer(customerId);
        return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "MIS policies for customer.", list));
    }

    // ──────────────────────────────────────────────────────────────────────
    //  GET payout ledger for a policy
    // ──────────────────────────────────────────────────────────────────────
    @GetMapping("/policies/{id}/ledger")
    public ResponseEntity<ApiResponse<List<MisPayoutLedger>>> getLedger(@PathVariable Long id) {
        List<MisPayoutLedger> ledger = misRenewalService.getLedgerByPolicyId(id);
        return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "Payout ledger fetched.", ledger));
    }

    // ──────────────────────────────────────────────────────────────────────
    //  GET policy summary
    // ──────────────────────────────────────────────────────────────────────
    @GetMapping("/policies/{id}/summary")
    public ResponseEntity<ApiResponse<MisSummaryDto>> getSummary(@PathVariable Long id) {
        MisSummaryDto summary = misRenewalService.getSummary(id);
        return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "MIS summary fetched.", summary));
    }

    // ──────────────────────────────────────────────────────────────────────
    //  POST premature close
    // ──────────────────────────────────────────────────────────────────────
    @PostMapping("/policies/{id}/premature-close")
    public ResponseEntity<ApiResponse<MisClosureAudit>> prematureClose(
            @PathVariable Long id,
            @RequestBody MisPrematureCloseRequestDto req) {
        MisClosureAudit audit = misRenewalService.prematureClose(id, req.getReason());
        return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "Policy prematurely closed.", audit));
    }

    // ──────────────────────────────────────────────────────────────────────
    //  POST renew
    // ──────────────────────────────────────────────────────────────────────
    @PostMapping("/policies/{id}/renew")
    public ResponseEntity<ApiResponse<MisPolicyResponseDto>> renew(@PathVariable Long id) {
        MisPolicy newPolicy = misRenewalService.renewPolicy(id);
        MisPolicyResponseDto dto = misRenewalService.toDto(newPolicy);
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(ApiResponse.success(HttpStatus.CREATED,
                        "Policy renewed. New policy number: " + newPolicy.getPolicyNumber(), dto));
    }

    // ──────────────────────────────────────────────────────────────────────
    //  POST manual payout trigger (for testing/admin use)
    // ──────────────────────────────────────────────────────────────────────
    @PostMapping("/admin/trigger-payouts")
    public ResponseEntity<ApiResponse<String>> triggerPayouts() {
        misRenewalService.processMonthlyPayouts();
        return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK,
                "MIS payout processing triggered successfully.", null));
    }

    // ──────────────────────────────────────────────────────────────────────
    //  POST add next payout (month-by-month testing & admin payout addition)
    // ──────────────────────────────────────────────────────────────────────
    @PostMapping("/policies/{id}/add-next-payout")
    public ResponseEntity<ApiResponse<MisPayoutLedger>> addNextPayout(@PathVariable Long id) {
        try {
            MisPayoutLedger ledger = misRenewalService.addNextPayout(id);
            return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK,
                    "Next payout added successfully for date: " + ledger.getPayoutDate(), ledger));
        } catch (IllegalStateException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(ApiResponse.error(HttpStatus.BAD_REQUEST, e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(ApiResponse.error(HttpStatus.INTERNAL_SERVER_ERROR, "Failed to add payout: " + e.getMessage()));
        }
    }
}
