function toggleMenu() {
  document.getElementById('dropdown-toggle').onclick = () => {
    const dropdownMenu = document.getElementById('dropdown-menu');
    dropdownMenu.classList.toggle('active');
  }
}
  document.addEventListener('turbolinks:load', function(){
    toggleMenu();
  });