<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="pagetitle">
    <h1>JOINT LIABILITY LOAN</h1>
    <nav>
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="openDashboard"><i class="bi bi-person-bounding-box"></i></a></li>
            <li class="breadcrumb-item">JOINT LIABILITY LOAN</li>
            <li class="breadcrumb-item action">LOAN APPROVAL</li>
        </ol>
    </nav>
</div>

<!-- MAIN APPRAISAL CARD -->
<div class="card shadow-sm border-0 mb-4">
    <div class="card-body p-4">
        <form id="approvalForm" novalidate>
            <!-- 1. DATA SEARCH / APPLICATION SELECTION -->
            <div class="mb-4">
                <nav>
                    <ol class="breadcrumb breadcrumb-title">
                        <li class="breadcrumb-item action">1. SELECT APPLICATION FOR REVIEW & APPROVAL</li>
                    </ol>
                </nav>
                <div class="row g-3 align-items-end">
                    <div class="col-lg-6 col-md-8">
                        <div class="d-flex flex-column formFields">
                            <label for="selectApplication">SELECT GROUP LOAN APPLICATION <span class="text-danger">*</span></label>
                            <select id="selectApplication" name="selectApplication" class="form-control selectField" style="height: 38px;">
                                <option value="">-- SELECT APPLICATION OR GROUP --</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-4">
                        <div class="d-flex flex-column formFields">
                            <label>CURRENT APPLICATION STATUS</label>
                            <div class="pt-1">
                                <span id="statusBadge" class="badge bg-secondary fs-6 py-2 px-3">NONE SELECTED</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 2. GROUP & LEADER PROFILE -->
            <div class="mb-4">
                <nav>
                    <ol class="breadcrumb breadcrumb-title">
                        <li class="breadcrumb-item action">2. GROUP & LEADER PROFILE</li>
                    </ol>
                </nav>
                <div class="row g-3">
                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="applicationNo">APPLICATION NO</label>
                            <input type="text" id="applicationNo" class="form-control bg-light fw-bold text-primary" readonly placeholder="APPLICATION NO" />
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="groupCode">GROUP CODE</label>
                            <input type="text" id="groupCode" class="form-control bg-light fw-bold" readonly placeholder="GROUP CODE" />
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="openingDate">APPLICATION DATE</label>
                            <input type="text" id="openingDate" class="form-control bg-light" readonly placeholder="APPLICATION DATE" />
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="communityName">COMMUNITY NAME</label>
                            <input type="text" id="communityName" class="form-control bg-light" readonly placeholder="COMMUNITY NAME" />
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="communityLeader">COMMUNITY LEADER</label>
                            <input type="text" id="communityLeader" class="form-control bg-light" readonly placeholder="COMMUNITY LEADER" />
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="leaderContactNumber">LEADER CONTACT NUMBER</label>
                            <input type="text" id="leaderContactNumber" class="form-control bg-light" readonly placeholder="LEADER CONTACT NUMBER" />
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="allocatedStaff">ALLOCATED STAFF</label>
                            <input type="text" id="allocatedStaff" class="form-control bg-light" readonly placeholder="ALLOCATED STAFF" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-12">
                        <div class="d-flex flex-column formFields">
                            <label for="leaderAddress">LEADER ADDRESS</label>
                            <input type="text" id="leaderAddress" class="form-control bg-light" readonly placeholder="LEADER ADDRESS" />
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-12">
                        <div class="d-flex flex-column formFields">
                            <label for="purposeOfLoan">PURPOSE OF LOAN</label>
                            <input type="text" id="purposeOfLoan" class="form-control bg-light" readonly placeholder="PURPOSE OF LOAN" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- 3. LOAN TERMS & REPAYMENT SCHEDULE -->
            <div class="mb-4">
                <nav>
                    <ol class="breadcrumb breadcrumb-title">
                        <li class="breadcrumb-item action">3. LOAN TERMS & REPAYMENT SCHEDULE</li>
                    </ol>
                </nav>
                <div class="row g-3">
                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="loanAmount">LOAN AMOUNT (₹)</label>
                            <input type="text" id="loanAmount" class="form-control bg-light fw-bold text-success" readonly placeholder="0.00" />
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="term">TERM (INSTALLMENTS)</label>
                            <input type="text" id="term" class="form-control bg-light" readonly placeholder="0" />
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="rateOfInterest">RATE OF INTEREST (% P.A.)</label>
                            <input type="text" id="rateOfInterest" class="form-control bg-light" readonly placeholder="0.00%" />
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="interestType">INTEREST TYPE</label>
                            <input type="text" id="interestType" class="form-control bg-light" readonly placeholder="FLAT / REDUCING" />
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="emiFrequency">EMI FREQUENCY</label>
                            <input type="text" id="emiFrequency" class="form-control bg-light" readonly placeholder="WEEKLY / MONTHLY" />
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="interestOnLoan">INTEREST ON LOAN (₹)</label>
                            <input type="text" id="interestOnLoan" class="form-control bg-light" readonly placeholder="0.00" />
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="totalAmountToPay">TOTAL AMOUNT TO PAY (₹)</label>
                            <input type="text" id="totalAmountToPay" class="form-control bg-light fw-bold text-dark" readonly placeholder="0.00" />
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="emiAmount">EMI AMOUNT (₹)</label>
                            <input type="text" id="emiAmount" class="form-control bg-light fw-bold text-primary" readonly placeholder="0.00" />
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="firstEmiDate">FIRST EMI DATE</label>
                            <input type="text" id="firstEmiDate" class="form-control bg-light" readonly placeholder="FIRST EMI DATE" />
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="totalDeduction">TOTAL DEDUCTION (₹)</label>
                            <input type="text" id="totalDeduction" class="form-control bg-light text-danger fw-bold" readonly placeholder="0.00" />
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="netDisbursement">NET DISBURSEMENT (₹)</label>
                            <input type="text" id="netDisbursement" class="form-control bg-light text-success fw-bold" readonly placeholder="0.00" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- 4. MEMBER LOAN ALLOCATIONS & IN-HAND DISBURSEMENTS -->
            <div class="mb-4">
                <nav>
                    <ol class="breadcrumb breadcrumb-title">
                        <li class="breadcrumb-item action">4. MEMBER LOAN ALLOCATION & IN-HAND DISBURSEMENT BREAKDOWN</li>
                    </ol>
                </nav>
                <div class="table-responsive">
                    <table class="table table-bordered table-striped align-middle">
                        <thead class="table-light">
                            <tr>
                                <th style="width: 15%;">MEMBER CODE</th>
                                <th style="width: 35%;">MEMBER NAME</th>
                                <th style="width: 25%;">INDIVIDUAL LOAN AMOUNT (₹)</th>
                                <th style="width: 25%;">NET DISBURSEMENT (AMOUNT CUSTOMER GETS) (₹)</th>
                            </tr>
                        </thead>
                        <tbody id="memberTableBody">
                            <tr>
                                <td colspan="4" class="text-center text-muted py-3">Select an application to view member breakdown</td>
                            </tr>
                        </tbody>
                        <tfoot class="table-light fw-bold" id="memberTableFoot" style="display: none;">
                            <tr>
                                <td colspan="2" class="text-end">TOTAL:</td>
                                <td id="totalMemberLoan">₹0.00</td>
                                <td id="totalMemberNetDisb" class="text-success">₹0.00</td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>

            <!-- 5. APPROVAL DECISION & ACTIONS -->
            <div class="mb-3">
                <nav>
                    <ol class="breadcrumb breadcrumb-title">
                        <li class="breadcrumb-item action">5. APPRAISAL DECISION & APPROVAL ACTIONS</li>
                    </ol>
                </nav>
                <div class="row g-3">
                    <div class="col-lg-3 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="approvalDate">DATE OF APPROVAL <span class="text-danger">*</span></label>
                            <input type="date" name="approvalDate" id="approvalDate" class="form-control" required style="text-transform: uppercase;" />
                        </div>
                    </div>
                    <div class="col-lg-9 col-md-6">
                        <div class="d-flex flex-column formFields">
                            <label for="approvalRemarks">APPROVAL / APPRAISAL REMARKS</label>
                            <input type="text" name="approvalRemarks" id="approvalRemarks" class="form-control" placeholder="ENTER APPRAISAL REMARKS OR REASON..." />
                        </div>
                    </div>
                </div>

                <div class="d-flex justify-content-end gap-3 mt-4">
                    <button type="button" id="rejectBtn" class="btn btn-outline-danger px-4 py-2 fw-bold" disabled>
                        <i class="bi bi-x-circle me-1"></i> REJECT APPLICATION
                    </button>
                    <button type="button" id="approveBtn" class="btn btn-success px-5 py-2 fw-bold" disabled>
                        <i class="bi bi-check-circle-fill me-1"></i> APPROVE GROUP LOAN
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>

<!-- 6. APPLICATIONS STATUS LIST -->
<div class="card shadow-sm border-0">
    <div class="card-body p-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <h5 class="card-title fw-bold mb-0">GROUP LOAN APPLICATIONS DIRECTORY</h5>
            <button type="button" id="refreshListBtn" class="btn btn-sm btn-outline-secondary">
                <i class="bi bi-arrow-clockwise me-1"></i> REFRESH LIST
            </button>
        </div>
        <div class="table-responsive">
            <table class="table table-bordered table-hover align-middle">
                <thead class="table-light">
                    <tr>
                        <th>APPLICATION NO</th>
                        <th>GROUP CODE</th>
                        <th>COMMUNITY</th>
                        <th>LOAN AMOUNT (₹)</th>
                        <th>DATE</th>
                        <th>STATUS</th>
                        <th>ACTION</th>
                    </tr>
                </thead>
                <tbody id="applicationsListBody">
                    <tr>
                        <td colspan="7" class="text-center text-muted py-3">Loading applications...</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    var globalContextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/js/Joinlibiliy/LoanApproval.js?v=<%=System.currentTimeMillis()%>"></script>
