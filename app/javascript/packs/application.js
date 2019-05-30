import "bootstrap";
import $ from 'jquery'
import 'star-rating-svg/dist/jquery.star-rating-svg'
import 'star-rating-svg/src/css/star-rating-svg.css'
import { initStripe } from "./plugins/initStripe"
import { initNavbar } from './navbar'

// Initialize plugins

initStripe();
initNavbar();

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

// Tenant Time Selection

const timeTiles = document.querySelectorAll('.time-card');
const timeSelected = document.querySelector("#time_selectors");
timeTiles.forEach(tile => {
  tile.addEventListener('click', (e) => {
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

// Contractor Category Selection

const categoryTiles = document.querySelectorAll('.category-card');
const categorySelected = document.querySelector("#category_selected");
categoryTiles.forEach(tile => {
  tile.addEventListener('click', (e) => {
    if (tile.classList.contains('contractor-active')) {
      tile.classList.remove('contractor-active')
      categorySelected.value = ''
    } else {
      categoryTiles.forEach(t => {
        t.classList.remove('contractor-active')
      })
      tile.classList.add('contractor-active')
      categorySelected.value = tile.dataset.id
    }
  })
})


// Job Resolved

const options = document.querySelectorAll('.time-card');
const jobResolved = document.querySelector("#resolved");
options.forEach(option => {
  option.addEventListener('click', (e) => {
    jobResolved.value = option.dataset.id
    console.log(jobResolved)
    if (option.classList.contains('contractor-active')) {
      option.classList.remove('contractor-active');
    } else {
      options.forEach(t => {
        t.classList.remove('contractor-active');
      })
      option.classList.add('contractor-active');
    }
  })
})

const jobRating = document.querySelector("#rating")
$('.rating').starRating({
  totalStars: 5,
  starSize: 40,
  disableAfterRate: false,
  callback: (rating, el) => {
    jobRating.value = rating
  }
})


// Confirmation Selection

// const confirmationTiles = document.querySelector('.confirmation-card');
// const confirmationSelected = document.querySelector("#confirmation_selectors");
// confirmationTiles.forEach(tile => {
//   tile.addEventListener('click', (e) => {
//     if (tile.classList.contains('contractor-active')) {
//       tile.classList.remove('contractor-active')
//       confirmationSelected.value = ''
//     } else {
//       confirmationTiles.forEach(t => {
//         t.classList.remove('contractor-active')
//       })
//       tile.classList.add('contractor-active')
//       confirmationSelected.value = tile.dataset.id
//     }
//   })
// })




