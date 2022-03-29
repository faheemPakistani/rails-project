document.querySelectorAll('.reply-btn').forEach((el)=>{
  el.addEventListener('click', (ev) =>{
      ev.preventDefault();
      el.nextElementSibling.style ='display: block;'
  })
})