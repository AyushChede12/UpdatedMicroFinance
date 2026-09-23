package com.microfinance.dto;

import java.math.BigDecimal;
import java.util.Map;

public class GoldRateDto {

	private String date;
	private Map<String, BigDecimal> rates;

	public GoldRateDto() {
	}

	public GoldRateDto(String date, Map<String, BigDecimal> rates) {
		this.date = date;
		this.rates = rates;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public Map<String, BigDecimal> getRates() {
		return rates;
	}

	public void setRates(Map<String, BigDecimal> rates) {
		this.rates = rates;
	}
}
