//Zach B's Changes
//Assumes nothing can be clicked before the page loads
var dimmingMask = null;
window.onload = function () {
    dimmingMask = document.getElementById("dimming-mask");
};

function openPopup() {
    dimmingMask.className = "dimming-mask-active";
}

function closePopup() {
    dimmingMask.className = "";
}

function closeDimMask(event) {
    if (event.target === dimmingMask) {
        closePopup();
    }
}
