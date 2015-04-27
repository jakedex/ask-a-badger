"use strict";

function changeSubmitOnFocus() {
    document.getElementById('submit').style.color = "#e6e8eb";
}

function changeSubmitOnBlur() {
    document.getElementById('submit').style.color = "#600700";
}

document.getElementById('tel').onfocus = changeSubmitOnFocus;
document.getElementById('tel').onblur = changeSubmitOnBlur;