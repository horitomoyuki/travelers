function pullDown() {

  const pullDownButton = document.getElementById("room-lists")
  const pullDownParents = document.getElementById("room-pull-down")
  const pullDownChild = document.querySelectorAll(".room-pull-down-list")

  pullDownButton.addEventListener('mouseover', function(){
    this.setAttribute("style", "background-color: #ffe863;")
  })

  pullDownButton.addEventListener('mouseout', function(){
    this.removeAttribute("style", "background-color: #ffe863;")
  })

  pullDownButton.addEventListener('click', function() {
    // プルダウンメニューの表示と非表示の設定
    if (pullDownParents.getAttribute("style") == "display:block;") {
      pullDownParents.removeAttribute("style", "display:block;")
    } else {
      pullDownParents.setAttribute("style", "display:block;")
    }
  })

  pullDownChild.addEventListener('mouseover', function(){
    this.setAttribute("style", "background-color:#182D46;")
  })

  pullDownChild.addEventListener('mouseout', function(){
    this.removeAttribute("style", "background-color:#182D46;")
  })

}

window.addEventListener('load', pullDown)