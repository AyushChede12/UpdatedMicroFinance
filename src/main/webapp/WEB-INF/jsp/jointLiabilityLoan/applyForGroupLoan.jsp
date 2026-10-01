<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="pagetitle">
    <h1>JOINT LIABILITY LOAN</h1>
    <nav>
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="openDashboard"><i class="bi bi-person-bounding-box"></i></a></li>
            <li class="breadcrumb-item action">APPLY FOR GROUP LOAN</li>
        </ol>
    </nav>
</div>

<div class="card shadow-sm border-0 mb-4">
    <div class="card-body p-4">
        <form id="groupLoanForm" novalidate>
            <!-- Hidden field for background collection day to calculate first EMI date -->
            <input type="hidden" name="scheduledCollectionDay" id="scheduledCollectionDay" />

            <!-- 1. GROUP SELECTION -->
            <div class="mb-4">
                <nav>
                    <ol class="breadcrumb breadcrumb-title">
                        <li class="breadcrumb-item action">1. GROUP SELECTION</li>
                    </ol>
                </nav>
                <div class="row">
                    <div class="col-lg-4 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="groupCode">FIND BY GROUP CODE <span class="text-danger">*</span></label>
                            <select id="groupCode" name="groupCode" required class="form-control selectField" style="height: 38px;">
                                <option value="">SELECT GROUP</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 2. GROUP PROFILE -->
            <div class="mb-4">
                <nav>
                    <ol class="breadcrumb breadcrumb-title">
                        <li class="breadcrumb-item action">2. GROUP PROFILE</li>
                    </ol>
                </nav>
                <div class="row g-3">
                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="openingDate">OPENING DATE <span class="text-danger">*</span></label>
                            <input type="date" name="openingDate" id="openingDate" class="form-control" required style="text-transform: uppercase;" />
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="communityName">COMMUNITY NAME</label>
                            <input type="text" name="communityName" id="communityName" class="form-control bg-light" readonly placeholder="COMMUNITY NAME" />
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="communityAddress">COMMUNITY ADDRESS</label>
                            <input type="text" name="communityAddress" id="communityAddress" class="form-control bg-light" readonly placeholder="ENTER COMMUNITY ADDRESS" />
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="allocatedStaff">ALLOCATED STAFF</label>
                            <input type="text" name="allocatedStaff" id="allocatedStaff" class="form-control bg-light" readonly placeholder="ALLOCATED STAFF" />
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="communityLeader">COMMUNITY LEADER</label>
                            <input type="text" name="communityLeader" id="communityLeader" class="form-control bg-light" readonly placeholder="M00001 - NAME" />
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="leaderContactNumber">LEADER CONTACT NUMBER</label>
                            <input type="text" name="leaderContactNumber" id="leaderContactNumber" class="form-control bg-light" readonly placeholder="LEADER CONTACT NUMBER" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="leaderAddress">LEADER ADDRESS</label>
                            <input type="text" name="leaderAddress" id="leaderAddress" class="form-control bg-light" readonly placeholder="ENTER LEADER ADDRESS" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="purposeOfLoan">PURPOSE OF LOAN <span class="text-danger">*</span></label>
                            <input type="text" name="purposeOfLoan" id="purposeOfLoan" class="form-control" required placeholder="ENTER PURPOSE OF LOAN" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- 3. LOAN TERMS -->
            <div class="mb-4">
                <nav>
                    <ol class="breadcrumb breadcrumb-title">
                        <li class="breadcrumb-item action">3. LOAN TERMS</li>
                    </ol>
                </nav>
                <div class="row g-3">
                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="loanAmount">LOAN AMOUNT (₹) <span class="text-danger">*</span></label>
                            <input type="number" step="0.01" min="1" name="loanAmount" id="loanAmount" class="form-control" required placeholder="ENTER LOAN AMOUNT" />
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="term">TERM (INSTALLMENTS) <span class="text-danger">*</span></label>
                            <input type="number" min="1" step="1" name="term" id="term" class="form-control" required placeholder="ENTER TERM" />
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="rateOfInterest">RATE OF INTEREST (% P.A.) <span class="text-danger">*</span></label>
                            <input type="number" step="0.01" min="0" max="100" name="rateOfInterest" id="rateOfInterest" class="form-control" required placeholder="ENTER RATE OF INTEREST" />
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="interestType">INTEREST TYPE <span class="text-danger">*</span></label>
                            <select id="interestType" name="interestType" required class="form-control selectField" style="height: 38px;">
                                <option value="FLAT" selected>FLAT</option>
                                <option value="REDUCING">REDUCING</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="emiFrequency">EMI FREQUENCY <span class="text-danger">*</span></label>
                            <select id="emiFrequency" name="emiFrequency" required class="form-control selectField" style="height: 38px;">
                                <option value="MONTHLY" selected>MONTHLY</option>
                                <option value="WEEKLY">WEEKLY</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="emiMode">EMI MODE <span class="text-danger">*</span></label>
                            <select id="emiMode" name="emiMode" required class="form-control selectField" style="height: 38px;">
                                <option value="ARREARS" selected>ARREARS</option>
                                <option value="ADVANCE">ADVANCE</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="interestOnLoan">INTEREST ON LOAN (₹)</label>
                            <input type="text" name="interestOnLoan" id="interestOnLoan" class="form-control bg-light font-weight-bold text-primary" readonly placeholder="0.00" />
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="totalAmountToPay">AMOUNT TO PAY WITH INTEREST (₹)</label>
                            <input type="text" name="totalAmountToPay" id="totalAmountToPay" class="form-control bg-light font-weight-bold text-dark" readonly placeholder="0.00" />
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="emiAmount">EMI AMOUNT (₹)</label>
                            <input type="text" name="emiAmount" id="emiAmount" class="form-control bg-light font-weight-bold text-success" readonly placeholder="0.00" />
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="firstEmiDate">FIRST EMI DATE</label>
                            <input type="date" name="firstEmiDate" id="firstEmiDate" class="form-control bg-light" readonly />
                        </div>
                    </div>
                </div>
            </div>

            <!-- 4. FINANCIAL DEDUCTIONS -->
            <div class="mb-4">
                <nav>
                    <ol class="breadcrumb breadcrumb-title">
                        <li class="breadcrumb-item action">4. FINANCIAL DEDUCTIONS</li>
                    </ol>
                </nav>
                <div class="row g-3">
                    <div class="col-lg-2 col-md-4">
                        <div class="d-flex flex-column formFields">
                            <label for="processingFeePercent">PROCESSING FEE (%)</label>
                            <input type="number" step="0.01" min="0" max="100" name="processingFeePercent" id="processingFeePercent" value="0.00" class="form-control deduction-calc" placeholder="0.00" />
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-4">
                        <div class="d-flex flex-column formFields">
                            <label for="legalChargesPercent">LEGAL CHARGES (%)</label>
                            <input type="number" step="0.01" min="0" max="100" name="legalChargesPercent" id="legalChargesPercent" value="0.00" class="form-control deduction-calc" placeholder="0.00" />
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-4">
                        <div class="d-flex flex-column formFields">
                            <label for="insuranceFeePercent">INSURANCE FEE (%)</label>
                            <input type="number" step="0.01" min="0" max="100" name="insuranceFeePercent" id="insuranceFeePercent" value="0.00" class="form-control deduction-calc" placeholder="0.00" />
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-4">
                        <div class="d-flex flex-column formFields">
                            <label for="valuationFeePercent">VALUATION FEE (%)</label>
                            <input type="number" step="0.01" min="0" max="100" name="valuationFeePercent" id="valuationFeePercent" value="0.00" class="form-control deduction-calc" placeholder="0.00" />
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-4">
                        <div class="d-flex flex-column formFields">
                            <label for="gstPercent">GST (%)</label>
                            <input type="number" step="0.01" min="0" max="100" name="gstPercent" id="gstPercent" value="0.00" class="form-control deduction-calc" placeholder="0.00" />
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-4">
                        <div class="d-flex flex-column formFields">
                            <label for="totalDeduction">TOTAL DEDUCTION (₹)</label>
                            <input type="text" name="totalDeduction" id="totalDeduction" class="form-control bg-light font-weight-bold text-danger" readonly placeholder="0.00" />
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 mt-2">
                        <div class="d-flex flex-column formFields">
                            <label for="netDisbursement">NET DISBURSEMENT (₹)</label>
                            <input type="text" name="netDisbursement" id="netDisbursement" class="form-control bg-light font-weight-bold text-success" readonly placeholder="0.00" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- 5. PENALTY -->
            <div class="mb-4">
                <nav>
                    <ol class="breadcrumb breadcrumb-title">
                        <li class="breadcrumb-item action">5. PENALTY</li>
                    </ol>
                </nav>
                <div class="row g-3">
                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="penaltyMode">PENALTY MODE</label>
                            <select id="penaltyMode" name="penaltyMode" class="form-control selectField" style="height: 38px;">
                                <option value="FIXED">FIXED</option>
                                <option value="PERCENTAGE">PERCENTAGE</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="monthlyPenalty">MONTHLY PENALTY</label>
                            <input type="number" step="0.01" min="0" name="monthlyPenalty" id="monthlyPenalty" value="0.00" class="form-control" placeholder="0.00" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- 6. MEMBER ALLOCATION TABLE -->
            <div class="mb-4">
                <div class="d-flex justify-content-between align-items-center mb-2">
                    <nav>
                        <ol class="breadcrumb breadcrumb-title mb-0">
                            <li class="breadcrumb-item action">6. MEMBER ALLOCATION</li>
                        </ol>
                    </nav>
                    <button type="button" id="autoSplitBtn" class="btn btn-sm btn-primary fw-bold shadow-sm">
                        <i class="bi bi-calculator me-1"></i> AUTO CALCULATE / SPLIT EQUALLY
                    </button>
                </div>
                <div class="table-responsive">
                    <table class="table table-bordered table-hover align-middle" id="memberAllocationTable">
                        <thead class="table-light">
                            <tr>
                                <th style="width: 50px;">#</th>
                                <th style="width: 140px;">MEMBER CODE</th>
                                <th>MEMBER NAME</th>
                                <th style="width: 220px;">INDIVIDUAL LOAN AMOUNT (₹) <span class="text-danger">*</span></th>
                                <th style="width: 230px;" class="text-success">NET DISBURSEMENT (AMOUNT CUSTOMER GETS) (₹)</th>
                                <th style="width: 180px;">INDIVIDUAL EMI (₹)</th>
                            </tr>
                        </thead>
                        <tbody id="memberAllocationBody">
                            <tr>
                                <td colspan="6" class="text-center text-muted py-3">Please select a Group Code to load member allocation list.</td>
                            </tr>
                        </tbody>
                        <tfoot class="table-light font-weight-bold">
                            <tr>
                                <td colspan="3" class="text-end">TOTALS:</td>
                                <td>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span>₹ <span id="memberTotalAllocated">0.00</span></span>
                                        <span class="text-muted">/ ₹ <span id="requiredLoanAmount">0.00</span></span>
                                    </div>
                                </td>
                                <td>
                                    <span class="text-success">Total In Hand: ₹ <span id="memberTotalNetDisb">0.00</span></span>
                                </td>
                                <td>
                                    <span class="text-primary">Total EMI: ₹ <span id="memberTotalEmi">0.00</span></span>
                                </td>
                            </tr>
                        </tfoot>
                    </table>
                </div>

                <!-- Red Warning on Mismatch -->
                <div id="memberMismatchAlert" class="alert alert-danger mt-2" style="display: none;" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                    <strong>Allocation Mismatch:</strong> Member amounts sum to <strong>₹<span id="alertAllocatedSum">0.00</span></strong>, but Loan Amount is <strong>₹<span id="alertRequiredAmount">0.00</span></strong>. (Difference: <strong>₹<span id="alertDifference">0.00</span></strong>). The sum must equal the Loan Amount.
                </div>
            </div>

            <!-- SUBMIT BUTTON -->
            <div class="row mt-4">
                <div class="col-12 text-end">
                    <button type="button" id="resetBtn" class="btn btn-secondary px-4 py-2 me-2">RESET</button>
                    <button type="submit" id="saveBtn" class="btn btn-success px-5 py-2 font-weight-bold">
                        <i class="bi bi-check-circle me-1"></i> SAVE APPLICATION
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>

<!-- APPLICATIONS LIST -->
<div class="card shadow-sm border-0 mt-4">
    <div class="card-body p-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h5 class="card-title fw-bold mb-0">APPLICATIONS LIST</h5>
            <button type="button" id="deleteAllBtn" class="btn btn-outline-danger btn-sm fw-bold">
                <i class="bi bi-trash3 me-1"></i> DELETE ALL GROUP LOANS
            </button>
        </div>
        <div class="table-responsive">
            <table class="table table-bordered table-striped align-middle">
                <thead class="table-light">
                    <tr>
                        <th>APPLICATION NO</th>
                        <th>GROUP CODE</th>
                        <th>OPENING DATE</th>
                        <th>LOAN AMOUNT (₹)</th>
                        <th>TERM</th>
                        <th>ROI (%)</th>
                        <th>INTEREST (₹)</th>
                        <th>TOTAL REPAY (₹)</th>
                        <th>EMI (₹)</th>
                        <th>FIRST EMI DATE</th>
                        <th>NET DISBURSEMENT (₹)</th>
                        <th>STATUS</th>
                    </tr>
                </thead>
                <tbody id="groupLoanBody">
                    <tr>
                        <td colspan="12" class="text-center text-muted">Loading applications...</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    var globalContextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/js/Joinlibiliy/ApplyForGroupLoan.js?v=<%=System.currentTimeMillis()%>"></script>
