$(document).ready(function() {
	// Get today's date in YYYY-MM-DD format
	const today = new Date().toISOString().split('T')[0];
	$('#applicationDate').val(today);
	$('#fromDate').val(today);
	$('#toDate').val(today);
	$('#approvalDate').val(today);
	$('#openingDate').val(today);//crateSavingAccount
	$('#transactionDate').val(today);
	$('#dateOfTransfer').val(today);

	$('#loanDate').val(today); //loan application


	$('#paymentDate').val(today);
	$('#closingDate').val(today);

	$('#dateloan').val(today);
	$('#transferDate').val(today); //savingAccountFundTransfer

	//Branch
	$.ajax({
		url: "api/preference/getAllBranchModule", // Add base path if needed like /api/preference/getAllBranchModule
		type: "GET",
		success: function(response) {
			if (response.status == "FOUND") {
				const branchList = response.data;
				$("#branchName").empty(); // Clear existing options
				$("#branchName").append("<option value=''>-- SELECT BRANCH --</option>");
				$("#closingbranchName").empty(); // Clear existing options
				$("#closingbranchName").append("<option value=''>-- Select Branch --</option>");

				for (let i = 0; i < branchList.length; i++) {
					let branch = branchList[i];
					let option = `<option value="${branch.branchName}">${(branch.branchName).toUpperCase()}</option>`;
					$("#branchName").append(option);

					$("#closingbranchName").append(option);
					$("#branch").append(option);

				}
			} else {
				alert("Error: " + response.message);
			}
		},
		error: function(xhr) {
			console.error("Error loading branches:", xhr.responseText);
			alert("Failed to load dropdown data.");
		}
	});
	

	//Relatives
	$.ajax({
		url: "api/preference/getAllRelativeModule", // Add base path if needed like /api/preference/getAllBranchModule
		type: "GET",
		success: function(response) {
			if (response.status == "FOUND") {
				const relativeList = response.data;
				$("#relationToApplicant").empty(); // Clear existing options
				$("#relationToApplicant").append("<option value=''>-- SELECT RELATIVE --</option>");
				$("#familyRelation").empty(); // Clear existing options
				$("#familyRelation").append("<option value=''>-- SELECT RELATIVE --</option>");

				for (let i = 0; i < relativeList.length; i++) {
					let relative = relativeList[i];
					let option = `<option value="${relative.relation}">${(relative.relation).toUpperCase()}</option>`;
					$("#relationToApplicant").append(option);
					$("#familyRelation").append(option);
				}
			} else {
				alert("Error: " + response.message);
			}
		},
		error: function(xhr) {
			console.error("Error loading branches:", xhr.responseText);
			alert("Failed to load dropdown data.");
		}
	});

});

document.addEventListener("DOMContentLoaded", function() {

	const handleToggleSidebar = () => {
		document.body.classList.toggle('toggle-sidebar');
	}

	const toggleSidebarBtn = document.querySelector('.toggle-sidebar-btn');
	if (toggleSidebarBtn) {
		toggleSidebarBtn.addEventListener('click', handleToggleSidebar);
	}
});



// view image from image upload

const dropArea = document.getElementById("drop-area");
const inputFile = document.getElementById("input-file");
const imgView = document.getElementById("img-view");
const text = document.getElementById("upload-text");

inputFile.addEventListener("change", uploadImage);

function uploadImage() {
	let imgLink = URL.createObjectURL(inputFile.files[0]);
	imgView.style.backgroundImage = `url(${imgLink})`
	imgView.textContent = "";
	imgView.style.border = 0;
	imgView.style.display = 'block'
	text.style.display = 'none';
}

dropArea.addEventListener("dragover", function(e) {
	e.preventDefault()
})

dropArea.addEventListener("drop", function(e) {
	e.preventDefault()
	inputFile.files = e.dataTransfer.files;
	uploadImage()
})

function changeImage(newImageSrc, selectedThumbnail) {
	var galleryId = selectedThumbnail.closest('.image-gallery').id;
	var bigImage = document.getElementById(galleryId).querySelector('.big-image img');
	bigImage.src = newImageSrc;

	var thumbnails = document.getElementById(galleryId).querySelectorAll('.thumbnail');
	thumbnails.forEach(function(thumbnail) {
		thumbnail.classList.remove('selected');
	});

	selectedThumbnail.classList.add('selected');
}



const drop = document.getElementById('select-btn1');
drop.addEventListener()

// toggal button

document.addEventListener('DOMContentLoaded', () => {
	const toggles = document.querySelectorAll('.toggle__input');

	toggles.forEach((toggle) => {
		// Initialize colors
		updateToggleColor(toggle);

		// console.log("updated toggle" , toggle)

		// Add change event listener
		toggle.addEventListener('change', () => {
			updateToggleColor(toggle);
			// console.log(${ toggle.dataset.toggleType } is now ${ toggle.checked });
		});
	});

	function updateToggleColor(input) {
		const label = input.nextElementSibling;
		if (input.checked) {
			label.style.backgroundColor = '#28a745'; // Green ON
		} else {
			label.style.backgroundColor = '#ccc'; // Gray OFF
		}
	}
});

const wrapper = document.querySelector('.wrapper');
selectBtn = wrapper.querySelector('.select-btn');
optionsdropbtn = wrapper.querySelector(".options");
dropBtnSearchInput = wrapper.querySelector(".dropsearchinp")

/*const countries = [
	"Afghanistan", "Algeria", "Argentina", "Australia", "Austria", "Bangladesh", "Botswana", "Brazil", "Cabo Verde", "Cambodia", "Cameroon", "Canada",
	"Chad", "Chile", "China", "Colombia", "Costa Rica", "Croatia", "Czech Republic", "Denmark", "Ecuador", "Egypt", "Fiji", "Finland", "France", "Georgia", "Germany", "Ghana", "Greece", "Hungary", "Iceland",
	"India", "Indonesia", "Italy", "Japan", "Jordan", "Kazakhstan", "Kenya", "Malawi", "Malaysia", "Maldives",
	"Nepal", "Netherlands", "New Zealand", "Oman", "Pakistan", "Paraguay", "Peru", "Philippines", "Poland", "Portugal", "Qatar",
	"Russia", "Saudi Arabia", "South Africa", "South Korea", "Spain", "Sri Lanka", "Switzerland", "Syria", "Thailand",
	"Turkey", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States of America", "Uruguay", "Venezuela", "Vietnam", "Yemen", "Zambia", "Zimbabwe"
];

function addCountry(selectedopt) {
	optionsdropbtn.innerHTML = ""
	countries.forEach(count => {
		let isSelected = count == selectedopt ? "selected" : ""
		let li = `<li onclick="updateName(this)" class="${isSelected}" >${count}</li>`;
		optionsdropbtn.insertAdjacentHTML("beforeend", li)
	})
}
addCountry()
*/
const major = [
	"Mr", "Ms", "Mrs"
];

function addmajor(selectedopt) {
	optionsdropbtn.innerHTML = ""
	major.forEach(count => {
		let isSelected = count == selectedopt ? "selected" : ""
		let li = `<li onclick="updateName(this)" class="${isSelected}" >${count}</li>`;
		optionsdropbtn.insertAdjacentHTML("beforeend", li)
	})
}
addmajor()

function updateName(selectedLi) {
	dropBtnSearchInput.value = "";
	addCountry(selectedLi.innerText)
	wrapper.classList.remove("active");
	selectBtn.firstElementChild.innerText = selectedLi.innerText;
}

dropBtnSearchInput.addEventListener("keyup", () => {
	let arr = [];
	let searchVal = dropBtnSearchInput.value.toLowerCase();
	arr = countries.filter(data => {
		return data.toLowerCase().startsWith(searchVal);

	}).map(data => `<li onclick="updateName(this)">${data}</li>`).join("")
	optionsdropbtn.innerHTML = arr ? arr : `<p>Oops! Country not found</p>`;
})

selectBtn.addEventListener("click", () => {
	wrapper.classList.toggle("active");
})

