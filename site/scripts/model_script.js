// Declarando algumas variáveis utilizando o JavaScript DOM

// Utilizando o JavaScript DOM para pegar o selector/elemento com a classe "modal-creation"
let modalExit = document.querySelector(".modal-exit");
let openModalExit = document.querySelector(".open-modal-exit");
let closeModalExit = document.querySelector(".close-modal-exit");

let openModalDisable = document.querySelector(".open-modal-disable");
let modalDisable = document.querySelector(".modal-disable");
let closeModalDisable = document.querySelector(".close-modal-disable");

// Estou adicionando uma função de evento, quando ter um click no elemento "openModalExit", o elemento "modal" irá aparecer
openModalExit.addEventListener("click", (e) => {
    modalExit.showModal();
});

// Estou adicionando uma função de evento, quando ter um click no elemento "openModalExit", o elemento "modal" irá aparecer
closeModalExit.addEventListener("click", (e) => {
    modalExit.close();
});

openModalDisable.addEventListener("click", (e) => {
    modalDisable.showModal();
})

closeModalDisable.addEventListener("click", (e) => {
    modalDisable.close();
});
