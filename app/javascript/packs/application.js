import "bootstrap";
import { initStripe } from "./plugins/initStripe"

// Initialize plugins

initStripe();

// Contractor Selection

const contractorSelected = document.querySelector("#contractor_selected")

const addContractorId = (event) => {
  activeTile(event);
  contractorSelected.value = contractorSelected.value + event.currentTarget.dataset.id + ",";
  event.currentTarget.removeEventListener("click", addContractorId)
  event.currentTarget.addEventListener("click", removeContractorId)
}

const removeContractorId = (event) => {
  activeTile(event);
  contractorSelected.value = contractorSelected.value.replace(`,${event.currentTarget.dataset.id},`, ",")
  event.currentTarget.removeEventListener("click", removeContractorId)
  event.currentTarget.addEventListener("click", addContractorId)
}

document.querySelectorAll(".contractor-card").forEach((contractor) => {
  contractor.addEventListener("click", addContractorId)
});

const activeTile = (event) => {
  event.currentTarget.classList.toggle("contractor-active");
}

// Quote Selection

const tiles = document.querySelectorAll('.quote-card');
const quoteSelected = document.querySelector("#quote_selected");
tiles.forEach(tile => {
  tile.addEventListener('click', (e) => {
    if (tile.classList.contains('contractor-active')) {
      tile.classList.remove('contractor-active')
      quoteSelected.value = ''
    } else {
      tiles.forEach(t => {
        t.classList.remove('contractor-active')
      })
      tile.classList.add('contractor-active')
      quoteSelected.value = tile.dataset.id
    }
  })
})

const timeTiles = document.querySelectorAll('.time-card');
const timeSelected = document.querySelector("#time_selectors");
timeTiles.forEach(tile => {
  tile.addEventListener('click', (e) => {
    console.log('I was clicked')
    if (tile.classList.contains('contractor-active')) {
      tile.classList.remove('contractor-active')
      timeSelected.value = ''
    } else {
      timeTiles.forEach(t => {
        t.classList.remove('contractor-active')
      })
      tile.classList.add('contractor-active')
      timeSelected.value = tile.dataset.date
    }
  })
})








