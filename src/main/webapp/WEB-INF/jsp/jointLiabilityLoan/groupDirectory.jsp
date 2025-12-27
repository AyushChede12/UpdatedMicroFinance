
<style type="text/css">
.upload-container {
	display: flex;
	gap: 40px;
	justify-content: flex-start;
	margin-top: 20px;
}

.upload-box {
	display: flex;
	flex-direction: column;
	align-items: center;
	width: 180px;
	font-family: 'Poppins', sans-serif;
}

.upload-box label.title {
	font-size: 14px;
	font-weight: 600;
	margin-bottom: 10px;
}

.upload-preview {
	width: 150px;
	height: 150px;
	border: 2px dashed #ccc;
	border-radius: 12px;
	overflow: hidden;
	display: flex;
	align-items: center;
	justify-content: center;
	background-color: #f9f9f9;
	cursor: pointer;
}

.upload-preview img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}
</style>

<div class="pagetitle">
	<h1>Joint Liability Loan</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"><i
					class="bi bi-person-bounding-box"></i></a></li>
			<li class="breadcrumb-item active">Group Directory</li>
		</ol>
	</nav>
</div>

<form id="groupdirectordform">
	<div class="row">
		<div class="col-12">
			<h4 style="font-size: 20px;">Group Info</h4>
		</div>
		<div class="col-lg-3" style="display: none;">
			<div class="d-flex flex-column formFields">
				<label>id*</label> <input type="text" id="id" name="id"
					class="form-control" required />
			</div>
		</div>
		<div class="col-lg-3" style="display: none;">
			<div class="d-flex flex-column formFields">
				<label>Group ID*</label> <input type="text" id="groupID"
					name="groupID" value="${memberCodeGD}" class="form-control"
					required />
			</div>
		</div>

		<div class="col-lg-3 ">
			<div class="d-flex flex-column formFields">
				<label>Community Name*</label> <input type="text" id="communityName"
					name="communityName" class="form-control" required
					placeholder="Enter Community Name" />
			</div>
		</div>

		<div class="col-lg-3 ">
			<div class="d-flex flex-column formFields">
				<label>Opening Date*</label> <input type="date" id="openingDate"
					name="openingDate" class="form-control" required />
			</div>
		</div>


		<div class="col-lg-3 mb-4 ">
			<div class="d-flex flex-column formFields">
				<label for="">Branch Name*</label> <select id="branchName"
					name="branchName" required="required"
					class="form-control selectField" style="height: 30px;">
					<option value="">Select Branch</option>
					<option>Branch A</option>
					<option>Branch B</option>
				</select>
			</div>
		</div>

		<!-- <div class="col-lg-3 ">
					<div class="d-flex flex-column formFields">
						<label></label> <input type="text"
							id="communityLeader" name="communityLeader" class="form-control"
							required placeholder="Enter Leader Name" />
					</div>
				</div> -->

		<div class="col-lg-3 mb-4 ">
			<div class="d-flex flex-column formFields">
				<label for="">Community Leader*</label> <select id="communityLeader"
					name="communityLeader" required="required"
					class="form-control selectField" style="height: 30px;">
					<option value="">Select Member</option>
				</select>
			</div>
		</div>


		<div class="col-lg-3 ">
			<div class="d-flex flex-column formFields">
				<label>Contact No.*</label> <input type="text" id="contactNo"
					name="contactNo" class="form-control" required maxlength="10"
					placeholder="Enter Contact No" />
			</div>
		</div>

		<div class="col-lg-3 ">
			<div class="d-flex flex-column formFields">
				<label>Community Address*</label> <input type="text"
					id="communityAddress" name="communityAddress" class="form-control"
					required placeholder="Enter Address" />
			</div>
		</div>


		<div class="col-lg-3 mb-4 ">
			<div class="d-flex flex-column formFields">
				<label for="">Allocated Staff*</label> <select id="allocatedStaff"
					name="allocatedStaff" required="required"
					class="form-control selectField" style="height: 30px;">
					<option value="">Select Staff</option>
					<option>Staff A</option>
					<option>Staff B</option>

				</select>
			</div>
		</div>

		<div class="col-lg-3 mb-4 ">
			<div class="d-flex flex-column formFields">
				<label for="">Scheduled Collection Days*</label> <select
					id="collectionDay" name="collectionDay" required="required"
					class="form-control selectField" style="height: 30px;">
					<option value="">Select Day</option>
					<option>Monday</option>
					<option>Wednesday</option>

				</select>
			</div>
		</div>

		<div class="col-lg-3 mb-4 ">
			<div class="d-flex flex-column formFields">
				<label for="">Scheduled Time*</label> <select id="collectionTime"
					name="collectionTime" required="required"
					class="form-control selectField" style="height: 30px;">
					<option value="">Select Time</option>
					<option>10:00 AM</option>
					<option>02:00 PM</option>
				</select>
			</div>
		</div>



	</div>

	<div class="row mt-4">
		<div class="col-lg-3 mb-5">
			<label for=""
				style="font-size: 12px; font-family: 'Poppins', sans-serif; font-weight: 700; margin-bottom: 5px;">Upload
				Photo <span class="star">*</span>
			</label> <label for="uploadPhoto" id="drop-area"> <input type="file"
				accept="image/*" name="uploadPhoto" id="uploadPhoto" hidden="hidden"
				onchange="photoUpload();"
				style="background-size: cover; background-repeat: no-repeat" />
				<div id="img-view">
					<img src="../images/upload/upload.png" alt="upload_icon"
						id="photoPreview" /><input type="hidden" name="photoHidden"
						id="photoHidden">

				</div>
			</label> <small id="chkphoto" style="color: red;"></small>
		</div>

		<div class="col-lg-3 mb-5">
			<label for=""
				style="font-size: 12px; font-family: 'Poppins', sans-serif; font-weight: 700; margin-bottom: 5px;">Upload
				Signature <span class="star">*</span>
			</label> <label for="uploadSignature" id="drop-area"> <input
				type="file" accept="image/*" name="uploadSignature"
				id="uploadSignature" hidden="hidden" onchange="signatureUpload();"
				style="background-size: cover; background-repeat: no-repeat" />
				<div id="img-view">
					<img src="../images/upload/upload.png" alt="upload_icon"
						id="signaturePreview" /><input type="hidden"
						name="signatureHidden" id="signatureHidden">

				</div>
			</label> <small id="chksignature" style="color: red;"></small>
		</div>


	</div>


	<hr class="mt-5" />
	<div class="col-12">
		<h4>Group Member Link</h4>
	</div>

	<div class="row">
		<div class="col-lg-3 mb-4 ">
			<div class="d-flex flex-column formFields">
				<label for="">Select Member*</label> <select id="selectedMember"
					name="selectedMember" required="required"
					class="form-control selectField" style="height: 30px;">
					<option value="">Select Member</option>
				</select>
			</div>
		</div>


		<div class="col-lg-3">
			<div class="d-flex flex-column formFields">
				<label>Customer Name*</label> <input type="text" id="customerName"
					name="customerName" class="form-control" required
					placeholder="Enter Member Name" />
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields">
				<label>Referral Details*</label> <input type="text"
					id="referralDetails" name="referralDetails" class="form-control"
					required placeholder="Enter Relative Details" />
			</div>
		</div>

		<div class="col-lg-3 ">
			<div class="d-flex flex-column formFields">
				<label>Contact*</label> <input type="text" id="contact"
					name="contact" class="form-control" maxlength="10" required
					placeholder="Enter Mobile Number" />
			</div>
		</div>



	</div>

	<div class="col-12 text-right">
		<button type="button" id="addque" class="btn btn-success mt-3">Add
			Que</button>
	</div>
	<div class="row mt-5">
		<div class="col-12">
			<div class="card recent-sales">
				<div class="card-body table-responsive">
					<h5 class="card-title">Details Search List</h5>
					<table class="table table-bordered" id="tab1">
						<thead class="thead-light">
							<tr>
								<th>id</th>
								<th>Customer Name</th>
								<th>Referral Details</th>
								<th>Contact</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>


						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>


	<div class="col-12 text-right">
		<button id="savegroupdirectory" type="button"
			class="btn btn-success mt-3">Save</button>
		<!-- <button id="updategroupdirectory" type="button"
						class="btn btn-success mt-3">Update</button> -->
		<button id="showGroupDirectory" type="button"
			class="btn btn-warning mt-3">Show Tabel</button>
	</div>


	<div class="row mt-5">
		<div class="col-12">
			<div class="card recent-sales">
				<div class="card-body table-responsive">
					<h5 class="card-title">Details Search List</h5>
					<table class="table table-bordered" id="">
						<thead class="thead-light">
							<tr>
								<th>Group ID</th>
								<th>Group Name</th>
								<th>Opening Date</th>
								<th>Assigned Branch</th>
								<th>Group Leader</th>
								<th>GL Contact No</th>
								<th>Community Address</th>
								<th>Allocated Staff</th>
								<th>Collection Day</th>
								<th>Collection Time</th>
								<th>Group Members ID's</th>
								<th>Group Members Name</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody id="groupDirectoryBody">


							<!-- More rows -->
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</form>

<script
	src="${pageContext.request.contextPath}/js/Joinlibiliy/GroupDirectory.js"></script>