package com.microfinance.dto;

import java.math.BigDecimal;
import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

public class GoldItemDto {

	private String itemName;
	private String itemType;

	@NotNull(message = "Karat is required")
	private Integer karat;

	@DecimalMin(value = "0.0", inclusive = false, message = "Customer Karat Rate must be greater than 0")
	private BigDecimal custgoldRate;

	private String lockerBranch;
	private BigDecimal purity;

	@Min(value = 1, message = "Item quantity must be at least 1")
	private Integer itemQty = 1;

	@NotNull(message = "Item weight is required")
	@DecimalMin(value = "0.001", message = "Item weight must be positive")
	private BigDecimal itemWt;

	private BigDecimal grossWt;

	@NotNull(message = "Stone weight is required")
	@DecimalMin(value = "0.0", message = "Stone weight cannot be negative")
	private BigDecimal stoneWt = BigDecimal.ZERO;

	private BigDecimal netWt;
	private BigDecimal marketValuation;
	private BigDecimal eligibleLoan;
	private String itemPhoto;

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getItemType() {
		return itemType;
	}

	public void setItemType(String itemType) {
		this.itemType = itemType;
	}

	public Integer getKarat() {
		return karat;
	}

	public void setKarat(Integer karat) {
		this.karat = karat;
	}

	public BigDecimal getCustgoldRate() {
		return custgoldRate;
	}

	public void setCustgoldRate(BigDecimal custgoldRate) {
		this.custgoldRate = custgoldRate;
	}

	public String getLockerBranch() {
		return lockerBranch;
	}

	public void setLockerBranch(String lockerBranch) {
		this.lockerBranch = lockerBranch;
	}

	public BigDecimal getPurity() {
		return purity;
	}

	public void setPurity(BigDecimal purity) {
		this.purity = purity;
	}

	public Integer getItemQty() {
		return itemQty;
	}

	public void setItemQty(Integer itemQty) {
		this.itemQty = itemQty;
	}

	public BigDecimal getItemWt() {
		return itemWt;
	}

	public void setItemWt(BigDecimal itemWt) {
		this.itemWt = itemWt;
	}

	public BigDecimal getGrossWt() {
		return grossWt;
	}

	public void setGrossWt(BigDecimal grossWt) {
		this.grossWt = grossWt;
	}

	public BigDecimal getStoneWt() {
		return stoneWt;
	}

	public void setStoneWt(BigDecimal stoneWt) {
		this.stoneWt = stoneWt;
	}

	public BigDecimal getNetWt() {
		return netWt;
	}

	public void setNetWt(BigDecimal netWt) {
		this.netWt = netWt;
	}

	public BigDecimal getMarketValuation() {
		return marketValuation;
	}

	public void setMarketValuation(BigDecimal marketValuation) {
		this.marketValuation = marketValuation;
	}

	public BigDecimal getEligibleLoan() {
		return eligibleLoan;
	}

	public void setEligibleLoan(BigDecimal eligibleLoan) {
		this.eligibleLoan = eligibleLoan;
	}

	public String getItemPhoto() {
		return itemPhoto;
	}

	public void setItemPhoto(String itemPhoto) {
		this.itemPhoto = itemPhoto;
	}
}
