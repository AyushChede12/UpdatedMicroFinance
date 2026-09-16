package com.microfinance.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/**
 * MisPayoutScheduler — daily scheduled job that drives MIS payout processing.
 *
 * Cron: "0 0 1 * * ?" = runs at 1:00 AM every day.
 * It delegates to MisRenewalService.processMonthlyPayouts() which:
 *   1. First processes matured policies
 *   2. Then processes monthly payouts for policies whose payoutDay = today
 */
@Component
public class MisPayoutScheduler {

    @Autowired
    private MisRenewalService misRenewalService;

    /**
     * Runs at 1:00 AM daily.
     * Checks all ACTIVE MIS policies for maturity and payout due.
     */
    @Scheduled(cron = "0 0 1 * * ?")
    public void runDailyMisProcessing() {
        System.out.println("MIS Scheduler: Daily processing started.");
        try {
            misRenewalService.processMonthlyPayouts();
            System.out.println("MIS Scheduler: Daily processing completed successfully.");
        } catch (Exception e) {
            System.err.println("MIS Scheduler: Error during daily processing: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
