// Declarando algumas variáveis utilizando o JavaScript DOM

// Utilizando o JavaScript DOM para pegar o selector/elemento com a classe "modal-creation"
let modalExit = document.querySelector(".modal-exit");
let openModalExit = document.querySelector(".open-modal-exit");
let closeModalExit = document.querySelector(".close-modal-exit");

let openModalDisable = document.querySelector(".open-modal-disable");
let modalDisable = document.querySelector(".modal-disable");
let closeModalDisable = document.querySelector(".close-modal-disable");

let openModalCancel = document.querySelector(".open-modal-cancel");
let modalCancel = document.querySelector(".modal-cancel");
let closeModalCancel = document.querySelector(".close-modal-cancel");

// Estou adicionando uma função de evento, quando ter um click no elemento "openModalExit", o elemento "modal" irá aparecer
if(openModalExit != null){
    openModalExit.addEventListener("click", (e) => {
        modalExit.showModal();
    });
}

// Estou adicionando uma função de evento, quando ter um click no elemento "openModalExit", o elemento "modal" irá aparecer
if(closeModalExit != null){
    closeModalExit.addEventListener("click", (e) => {
        modalExit.close();
    });
}

if(openModalDisable != null){
    openModalDisable.addEventListener("click", (e) => {
        modalDisable.showModal();
    })
}

if(closeModalDisable != null){
    closeModalDisable.addEventListener("click", (e) => {
        modalDisable.close();
    });
}

if(openModalCancel != null){
    openModalCancel.addEventListener("click", (e) => {
        modalCancel.showModal();
    });
}

if(closeModalCancel != null){
    closeModalCancel.addEventListener("click", (e) => {
        modalCancel.close();
    });
}