package com.microfinance.controller;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.microfinance.dto.ApiResponse;
import com.microfinance.model.GoldDirectory;
import com.microfinance.repository.GoldDirectoryRepo;

@RestController
@RequestMapping("/api/gold-rate")
public class GoldRateController {

	@Autowired
	private GoldDirectoryRepo goldDirectoryRepo;

	// Baseline 24K benchmark rate per gram (INR) if no manual rate is recorded today
	private static final BigDecimal BASE_24K_RATE = new BigDecimal("7500.00");

	@GetMapping("/today")
	public ResponseEntity<ApiResponse<Map<String, Object>>> getTodayGoldRate(
			@RequestParam(value = "karat", required = false) String requestedKarat) {

		Map<String, BigDecimal> rates = new LinkedHashMap<>();

		// Check if any recent rate is configured in GoldDirectory
		try {
			List<GoldDirectory> directories = goldDirectoryRepo.findAll();
			if (directories != null && !directories.isEmpty()) {
				for (GoldDirectory gd : directories) {
					if (gd.getKarat() != null && gd.getCustgoldRate() != null) {
						try {
							String k = gd.getKarat().trim();
							BigDecimal r = new BigDecimal(gd.getCustgoldRate().trim());
							if (r.compareTo(BigDecimal.ZERO) > 0) {
								rates.put(k, r.setScale(2, RoundingMode.HALF_UP));
							}
						} catch (Exception ignored) {
						}
					}
				}
			}
		} catch (Exception e) {
			// fallback
		}

		// Ensure all standard karats (18, 20, 22, 24) are present
		BigDecimal rate24 = rates.getOrDefault("24", BASE_24K_RATE);
		rates.put("24", rate24.setScale(2, RoundingMode.HALF_UP));

		if (!rates.containsKey("22")) {
			rates.put("22", rate24.multiply(new BigDecimal("22")).divide(new BigDecimal("24"), 2, RoundingMode.HALF_UP));
		}
		if (!rates.containsKey("20")) {
			rates.put("20", rate24.multiply(new BigDecimal("20")).divide(new BigDecimal("24"), 2, RoundingMode.HALF_UP));
		}
		if (!rates.containsKey("18")) {
			rates.put("18", rate24.multiply(new BigDecimal("18")).divide(new BigDecimal("24"), 2, RoundingMode.HALF_UP));
		}

		Map<String, Object> result = new LinkedHashMap<>();
		result.put("date", LocalDate.now().toString());
		result.put("rates", rates);

		if (requestedKarat != null && !requestedKarat.trim().isEmpty()) {
			String cleanKarat = requestedKarat.trim().replace("K", "").replace("k", "");
			BigDecimal singleRate = rates.get(cleanKarat);
			result.put("karat", cleanKarat);
			result.put("rate", singleRate != null ? singleRate : rates.get("22"));
		}

		return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "Gold rates fetched successfully", result));
	}
}
