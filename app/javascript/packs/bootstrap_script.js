import '../styles/home.scss'
import $ from 'jquery';
import 'select2/src/scss/core.scss';
import 'select2';
import 'bootstrap';

document.addEventListener('DOMContentLoaded', () => {
    $('.item-with-select2').select2({language: 'ru', multiple: true})
})