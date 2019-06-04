
// const selectedItems = document.getElementById(".tab-selectors")

const tabs = document.querySelectorAll(".tab-selectors");


const setActiveTab = (selectedTab) => {
  tabs.forEach(tab => tab.classList.remove('active-tab'))
  selectedTab.classList.add('active-tab')
}

tabs.forEach((tab) => {
  tab.addEventListener("click", (event) => {
    const selectedTab = event.currentTarget;
    setActiveTab(selectedTab)
    const statusTabWithShow = document.querySelector(".show-tab");
    if(selectedTab.dataset.id == '1') {
      const statusTab = document.querySelector(`div[data-tab-id="1"]`);
      if(statusTab.classList.contains('show-tab') == false) {
        statusTab.classList.add("show-tab");
        statusTabWithShow.classList.remove("show-tab");
      }
    }
    if(selectedTab.dataset.id == '2') {
      const statusTab = document.querySelector(`div[data-tab-id="2"]`);
      if(statusTab.classList.contains('show-tab') == false) {
        statusTab.classList.add("show-tab");
        statusTabWithShow.classList.remove("show-tab");
      }
    }
  });
});


