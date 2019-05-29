import "bootstrap";
import { initStripe } from "./plugins/initStripe"
import { initNavbar } from './navbar'

// Initialize plugins

initStripe();
initNavbar();

const contractorSelected = document.querySelector("#contractor_selected")

const addContractorId = (event) => {
  event.currentTarget.classList.toggle("contractor-active");
  contractorSelected.value = contractorSelected.value + event.currentTarget.dataset.id + ",";
  event.currentTarget.removeEventListener("click", addContractorId)
  event.currentTarget.addEventListener("click", removeContractorId)
}

const removeContractorId = (event) => {
  event.currentTarget.classList.toggle("contractor-active");
  contractorSelected.value = contractorSelected.value.replace(`,${event.currentTarget.dataset.id},`, ",")
  event.currentTarget.removeEventListener("click", removeContractorId)
  event.currentTarget.addEventListener("click", addContractorId)
}

document.querySelectorAll(".contractor-card").forEach((contractor) => {
  contractor.addEventListener("click", addContractorId)
});

