
function calculateEMI() {
  const roitype = document.getElementById("intrestType").value;
  const emicollection = document.getElementById("interestModeCalculater").value;
  const interestinyear = parseFloat(document.getElementById("yearlyIntrest").value);
  const loanamount = parseFloat(document.getElementById("loanAmount").value);
  const tensure = parseInt(document.getElementById("monthlyTerm").value);

  const periods = tensure; // ✅ ALWAYS use entered term — no conversion!
  let periodicRate;

  // ✅ Only adjust the rate — periods stays fixed
  switch (emicollection) {
    case "Daily":
      periodicRate = interestinyear / 365 / 100;
      break;
    case "Weekly":
      periodicRate = interestinyear / 52 / 100;
      break;
    case "Fortnightly":
      periodicRate = interestinyear / 24 / 100;
      break;
    case "Monthly":
      periodicRate = interestinyear / 12 / 100;
      break;
    case "Quarterly":
      periodicRate = interestinyear / 4 / 100;
      break;
  }

  let emi, tabledata = '', principal, currentDate = new Date();

  if (roitype === "FlatInterest") {
    const totalInterest = loanamount * periodicRate * periods;
    const totalAmount = loanamount + totalInterest;
    emi = totalAmount / periods;

    document.getElementById("emi").value = emi.toFixed(2);

    principal = loanamount;

    for (let m = 1; m <= periods; m++) {
      const interestComponent = totalInterest / periods;
      const principalComponent = emi - interestComponent;
      let closingPrincipal = principal - principalComponent;

      if (Math.abs(closingPrincipal) < 0.01) closingPrincipal = 0.00;

      tabledata += buildRow(m, currentDate, emi, principalComponent, interestComponent, closingPrincipal);

      principal = closingPrincipal;
      currentDate = incrementDate(currentDate, emicollection);
    }
  }

  else if (roitype === "reducinginterest") {
    const r = periodicRate;
    emi = (loanamount * r * Math.pow(1 + r, periods)) / (Math.pow(1 + r, periods) - 1);

    document.getElementById("emi").value = emi.toFixed(2);

    principal = loanamount;

    for (let m = 1; m <= periods; m++) {
      const interestComponent = principal * r;
      const principalComponent = emi - interestComponent;
      let closingPrincipal = principal - principalComponent;

      if (Math.abs(closingPrincipal) < 0.01) closingPrincipal = 0.00;

      tabledata += buildRow(m, currentDate, emi, principalComponent, interestComponent, closingPrincipal);

      principal = closingPrincipal;
      currentDate = incrementDate(currentDate, emicollection);
    }
  }

  else if (roitype === "Rule78") {
    const totalInterest = loanamount * periodicRate * periods;
    const sumOfDigits = (periods * (periods + 1)) / 2;

    let interestPerPeriod = [];
    for (let i = periods; i >= 1; i--) {
      interestPerPeriod.push((i / sumOfDigits) * totalInterest);
    }

    const totalAmount = loanamount + totalInterest;
    emi = totalAmount / periods;

    document.getElementById("emi").value = emi.toFixed(2);

    principal = loanamount;
    const principalComponent = loanamount / periods;

    for (let m = 1; m <= periods; m++) {
      const interestComponent = interestPerPeriod[m - 1];
      const installment = principalComponent + interestComponent;
      let closingPrincipal = principal - principalComponent;

      if (Math.abs(closingPrincipal) < 0.01) closingPrincipal = 0.00;

      tabledata += buildRow(m, currentDate, installment, principalComponent, interestComponent, closingPrincipal);

      principal = closingPrincipal;
      currentDate = incrementDate(currentDate, emicollection);
    }
  }

  document.querySelector('.datatable').classList.add('show');
  document.getElementById('tbody').innerHTML = tabledata;
}

// ✅ Helper: Format row
function buildRow(m, dateObj, installment, principalComponent, interestComponent, closingPrincipal) {
  const day = String(dateObj.getDate()).padStart(2, '0');
  const month = String(dateObj.getMonth() + 1).padStart(2, '0');
  const year = dateObj.getFullYear();
  const formattedDate = `${day}-${month}-${year}`;

  return `
    <tr>
      <td>${m}</td>
      <td>${formattedDate}</td>
      <td>${installment.toFixed(2)}</td>
      <td>${principalComponent.toFixed(2)}</td>
      <td>${interestComponent.toFixed(2)}</td>
      <td>${closingPrincipal.toFixed(2)}</td>
    </tr>`;
}

// ✅ Helper: Increment date for next payment
function incrementDate(date, mode) {
  const newDate = new Date(date);
  if (mode === "Daily") newDate.setDate(newDate.getDate() + 1);
  else if (mode === "Weekly") newDate.setDate(newDate.getDate() + 7);
  else if (mode === "Fortnightly") newDate.setDate(newDate.getDate() + 14);
  else if (mode === "Monthly") newDate.setMonth(newDate.getMonth() + 1);
  else if (mode === "Quarterly") newDate.setMonth(newDate.getMonth() + 3);
  return newDate;
}
